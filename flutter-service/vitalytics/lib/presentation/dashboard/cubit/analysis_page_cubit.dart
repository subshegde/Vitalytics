import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/core/constants/api_endpoints.dart';
import 'package:vitalytics/core/network/dio_client.dart';
import 'package:get_it/get_it.dart';
import 'package:vitalytics/data/db/disease_detection_dao.dart';
import 'package:vitalytics/data/models/disease_detection/disease_detection_model.dart';
import 'package:vitalytics/presentation/dashboard/cubit/analysis_page_state.dart';
import 'package:dio/dio.dart';
import 'package:vitalytics/sl.dart';
import 'package:image/image.dart' as img;

class AnalysisCubit extends Cubit<AnalysisState> {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  AnalysisCubit() : super(AnalysisInitial());

  void selectImage(File image) {
    emit(AnalysisImageSelected(image));
  }


  Future<void> uploadImage({required String userId}) async {
    final currentState = state;
    if (currentState is! AnalysisImageSelected) return;

    emit(AnalysisLoading());

    try {
      final file = currentState.image;

      final originalBytes = await file.readAsBytes();
      final decoded = img.decodeImage(originalBytes);

      final compressed = img.encodeJpg(decoded!, quality: 70);


      final base64Image = base64Encode(compressed);




      final data = {
        "user_id": userId,
        "image_base64": base64Image,
        "query": "string",
      };

      // -----------------------------
      // 4️⃣ SEND API REQUEST
      // -----------------------------
      final response = await _dioClient.post(
        ApiEndpoints.detectDisease,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        // Convert API response to model
        final disease = DiseaseDetectionModel(
          detected_disease: responseData['detected_disease'] ?? '',
          confidence_score:
          (responseData['confidence_score'] ?? 0).toDouble(),
          description: responseData['description'] ?? '',
          precautionary_steps:
          List<String>.from(responseData['precautionary_steps'] ?? []),
        );

        // Save to DB
        final prefs = sl<SharedPreferences>();
        final loggedUserId = prefs.getInt('logged_in_user_id') ?? 0;
        final dao = DiseaseDetectionDao();
        await dao.insertDisease(disease, loggedUserId);

        emit(AnalysisUploaded(responseData));
      } else {
        emit(AnalysisError(
            response.data?['message'] ?? 'Unexpected server response'));
      }
    } on DioException catch (e) {
      emit(
        AnalysisError(
          e.response?.data['message'] ??
              'Server error: ${e.response?.statusCode}',
        ),
      );
    } catch (e) {
      emit(AnalysisError(e.toString()));
    }
  }


  void removeImage() {
    emit(AnalysisInitial());
  }
}

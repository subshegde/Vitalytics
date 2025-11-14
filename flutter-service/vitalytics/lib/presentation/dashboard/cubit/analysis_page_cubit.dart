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
      final fileName = currentState.image.path.split('/').last;

      final data = {
        "user_id": userId,
        "filename": "images/$fileName",
        "query": "string",
      };

      final response = await _dioClient.post(
        ApiEndpoints.detectDisease,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        // Convert API response to DiseaseDetectionModel
        final disease = DiseaseDetectionModel(
          detected_disease: responseData['detected_disease'] ?? '',
          confidence_score: (responseData['confidence_score'] ?? 0).toDouble(),
          description: responseData['description'] ?? '',
          precautionary_steps: List<String>.from(
            responseData['precautionary_steps'] ?? [],
          ),
        );

        // Save to SQLite DB
        final prefs = sl<SharedPreferences>();
        final userId = prefs.getInt('logged_in_user_id');
        final dao = DiseaseDetectionDao();
        await dao.insertDisease(disease, userId ?? 0);

        emit(AnalysisUploaded(responseData));
      } else {
        emit(
          AnalysisError(
            response.data?['message'] ?? 'Unexpected server response',
          ),
        );
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        emit(
          AnalysisError(
            e.response?.data['message'] ??
                'Server returned an error: ${e.response?.statusCode}',
          ),
        );
      } else {
        emit(AnalysisError(e.message ?? "Something went wrong"));
      }
    } catch (e) {
      emit(AnalysisError(e.toString()));
    }
  }

  void removeImage() {
    emit(AnalysisInitial());
  }
}

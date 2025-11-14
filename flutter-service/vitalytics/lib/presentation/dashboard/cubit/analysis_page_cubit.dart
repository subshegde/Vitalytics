import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalytics/core/constants/api_endpoints.dart';
import 'package:vitalytics/core/network/dio_client.dart';
import 'package:get_it/get_it.dart';
import 'package:vitalytics/presentation/dashboard/cubit/analysis_page_state.dart';
import 'package:dio/dio.dart';

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
        emit(AnalysisUploaded(response.data));
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

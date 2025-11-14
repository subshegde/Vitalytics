import 'package:bloc/bloc.dart';
import 'package:vitalytics/core/constants/api_endpoints.dart';
import 'package:vitalytics/core/network/dio_client.dart';
import 'package:vitalytics/data/models/suggestion/suggestion_result.dart';
import 'package:vitalytics/presentation/dashboard/cubit/recomend_state.dart';

import '../../../sl.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit() : super(RecommendationInitial());

  Future<void> fetchRecommendations(
    int userId,
    String suggType,
    String diseaseType,
  ) async {
    emit(RecommendationLoading());

    try {
      final dio = sl<DioClient>();
      print("$suggType$diseaseType");
      final response = await dio.post(
        ApiEndpoints.suggestion,
        data: {
          "user_id": userId.toString(),
          "suggestion_type": suggType,
          "disease_type": diseaseType,
          "query": "string",
        },
      );

      final data = SuggestionResult.fromJson(response.data);

      emit(RecommendationLoaded(data));
    } catch (e) {
      emit(RecommendationError(e.toString()));
    }
  }
}

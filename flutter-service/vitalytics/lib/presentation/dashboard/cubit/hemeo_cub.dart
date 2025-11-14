import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalytics/presentation/dashboard/cubit/recomend_state.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../data/models/suggestion/suggestion_result.dart';
import '../../../sl.dart';

class HomeopathyRecommendationCubit extends Cubit<RecommendationState> {
  HomeopathyRecommendationCubit() : super(RecommendationInitial());

  Future<void> fetchHomeopathyRecommendations(
      int userId,
      String diseaseName,
      ) async {
    emit(RecommendationLoading());

    try {
      final dio = sl<DioClient>();

      final response = await dio.post(
        ApiEndpoints.suggestion,
        data: {
          "user_id": "$userId",
          "suggestion_type": "homeopathy",
          "disease_type": diseaseName,
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

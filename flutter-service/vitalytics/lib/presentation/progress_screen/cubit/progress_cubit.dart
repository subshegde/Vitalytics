import 'package:bloc/bloc.dart';
import 'package:vitalytics/presentation/progress_screen/cubit/progress_state.dart';
import 'package:vitalytics/sl.dart';
import 'package:vitalytics/core/network/dio_client.dart';
import 'package:vitalytics/core/constants/api_endpoints.dart';
import '../../../data/models/progression/progression_result.dart';


class ProgressSummaryCubit extends Cubit<ProgressSummaryState> {
  ProgressSummaryCubit() : super(ProgressSummaryInitial());

  Future<void> fetchProgressSummary(int userId,String base64) async {
    emit(ProgressSummaryLoading());

    try {
      final dio = sl<DioClient>();
      print("userId$userId");

      final response = await dio.post(
        ApiEndpoints.progression,
        data: {
          "user_id":userId.toString(),
          "image_base64": base64,
          "query": ""
        }
      );
      print("yesssss");

      final summary = ProgressSummaryModel.fromJson(response.data);

      emit(ProgressSummaryLoaded(summary));
    } catch (e) {
      emit(ProgressSummaryError(e.toString()));
    }
  }
}

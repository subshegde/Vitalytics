import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalytics/core/constants/api_endpoints.dart';
import 'package:vitalytics/core/network/dio_client.dart';
import 'package:vitalytics/data/models/full_summary/full_summary.dart';
import 'package:vitalytics/presentation/summary/cubit/summary_state.dart';
import 'package:get_it/get_it.dart';

class FullSummaryCubit extends Cubit<FullSummaryState> {
  final DioClient _client = GetIt.instance<DioClient>();

  FullSummaryCubit() : super(FullSummaryInitial());

  Future<void> fetchSummary(String userId, String query) async {
    emit(FullSummaryLoading());

    try {
      print('userid $userId');
      final response = await _client.post(
        ApiEndpoints.fullSummary,
        data: {
          "user_id": userId,
          "query": query,
        },
      );

      final summary = FullSummary.fromJson(response.data);
      emit(FullSummaryLoaded(summary));
    } catch (e) {
      emit(FullSummaryError(e.toString()));
    }
  }
}

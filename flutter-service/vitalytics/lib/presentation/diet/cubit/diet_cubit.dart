import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vitalytics/core/constants/api_endpoints.dart';
import 'package:vitalytics/core/network/dio_client.dart';
import 'package:vitalytics/data/models/diet/diet_summary.dart';
import 'package:vitalytics/data/request/diet_request.dart';
import 'diet_state.dart';

class DietCubit extends Cubit<DietState> {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  DietCubit() : super(DietInitial());

  Future<void> fetchDiet(DietRequest request) async {
    emit(DietLoading());
    try {
      final response = await _dioClient.post(
        ApiEndpoints.dietSummary,
        data: {
          "user_id": request.userId,
          "disease_type": request.diseaseType,
          "query": "",
        },
      );

      final data = DietModel.fromJson(response.data);

      emit(DietLoaded(data));
    } catch (e) {
      emit(DietError("Failed to load diet data"));
    }
  }
}

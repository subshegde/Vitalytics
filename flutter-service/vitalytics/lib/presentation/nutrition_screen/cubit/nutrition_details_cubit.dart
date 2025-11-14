import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vitalytics/core/constants/api_endpoints.dart';
import 'package:vitalytics/core/network/dio_client.dart';
import 'package:vitalytics/data/models/nutrition/nutrition_details.dart';
import 'package:vitalytics/data/request/nutrition_request.dart';
import 'nutrition_details_state.dart';

class NutritionDetailsCubit extends Cubit<NutritionDetailsState> {
  final DioClient _dio = GetIt.instance<DioClient>();

  NutritionDetailsCubit() : super(NutritionDetailsInitial());

  Future<void> fetchNutritionDetails(NutritionRequest request) async {
    emit(NutritionDetailsLoading());
    try {
       final reqBody = {
        "name": request.name,
        "disease_type": request.diseaseType,
        "query": "string"
      };
      print('request.toJson() ${request.toJson()}');
      final res = await _dio.post(
        ApiEndpoints.search,
        data: reqBody,
      );

      final model = NutritionDetailsModel.fromJson(res.data);

      emit(NutritionDetailsLoaded(model));
    } catch (e) {
      emit(NutritionDetailsError(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../models/progress_image_model.dart';
import 'get_image_state.dart';

class ProgressImagesCubit extends Cubit<ProgressImagesState> {
  final DioClient dio = GetIt.instance<DioClient>();

  ProgressImagesCubit() : super(ProgressImagesInitial());

  Future<void> fetchProgressImages(int userId) async {
    emit(ProgressImagesLoading());

    try {
      final response = await dio.post(
        "${ApiEndpoints.getImages}?user_id=$userId",
      );

      final data = ProgressImagesModel.fromJson(response.data);
      emit(ProgressImagesLoaded(data));
    } catch (e) {
      emit(ProgressImagesError(e.toString()));
    }
  }
}

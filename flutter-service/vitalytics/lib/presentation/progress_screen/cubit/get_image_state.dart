import '../models/progress_image_model.dart';

abstract class ProgressImagesState {}

class ProgressImagesInitial extends ProgressImagesState {}

class ProgressImagesLoading extends ProgressImagesState {}

class ProgressImagesLoaded extends ProgressImagesState {
  final ProgressImagesModel data;
  ProgressImagesLoaded(this.data);
}

class ProgressImagesError extends ProgressImagesState {
  final String message;
  ProgressImagesError(this.message);
}

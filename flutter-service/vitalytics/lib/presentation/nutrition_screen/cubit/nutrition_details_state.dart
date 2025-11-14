import 'package:equatable/equatable.dart';
import 'package:vitalytics/data/models/nutrition/nutrition_details.dart';

abstract class NutritionDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NutritionDetailsInitial extends NutritionDetailsState {}

class NutritionDetailsLoading extends NutritionDetailsState {}

class NutritionDetailsLoaded extends NutritionDetailsState {
  final NutritionDetailsModel data;

  NutritionDetailsLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class NutritionDetailsError extends NutritionDetailsState {
  final String message;

  NutritionDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

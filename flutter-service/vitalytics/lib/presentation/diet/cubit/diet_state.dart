import 'package:equatable/equatable.dart';
import 'package:vitalytics/data/models/diet/diet_summary.dart';

abstract class DietState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DietInitial extends DietState {}

class DietLoading extends DietState {}

class DietLoaded extends DietState {
  final DietModel dietModel;

  DietLoaded(this.dietModel);

  @override
  List<Object?> get props => [dietModel];
}

class DietError extends DietState {
  final String message;

  DietError(this.message);

  @override
  List<Object?> get props => [message];
}

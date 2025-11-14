import 'package:equatable/equatable.dart';
import 'package:vitalytics/data/models/full_summary/full_summary.dart';

abstract class FullSummaryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FullSummaryInitial extends FullSummaryState {}

class FullSummaryLoading extends FullSummaryState {}

class FullSummaryLoaded extends FullSummaryState {
  final FullSummary summary;

  FullSummaryLoaded(this.summary);

  @override
  List<Object?> get props => [summary];
}

class FullSummaryError extends FullSummaryState {
  final String message;

  FullSummaryError(this.message);

  @override
  List<Object?> get props => [message];
}

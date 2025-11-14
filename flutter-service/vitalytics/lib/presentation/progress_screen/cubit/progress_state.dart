import '../../../data/models/progression/progression_result.dart';

abstract class ProgressSummaryState {}

class ProgressSummaryInitial extends ProgressSummaryState {}

class ProgressSummaryLoading extends ProgressSummaryState {}

class ProgressSummaryLoaded extends ProgressSummaryState {
  final ProgressSummaryModel summary;

  ProgressSummaryLoaded(this.summary);
}

class ProgressSummaryError extends ProgressSummaryState {
  final String message;

  ProgressSummaryError(this.message);
}

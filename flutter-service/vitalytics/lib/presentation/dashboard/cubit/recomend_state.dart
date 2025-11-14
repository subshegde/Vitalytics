import '../../../data/models/suggestion/suggestion_result.dart';

abstract class RecommendationState {}

class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationLoaded extends RecommendationState {
  final SuggestionResult data;
  RecommendationLoaded(this.data);
}

class RecommendationError extends RecommendationState {
  final String message;
  RecommendationError(this.message);
}

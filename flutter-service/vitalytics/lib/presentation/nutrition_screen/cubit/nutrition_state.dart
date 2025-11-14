import 'package:equatable/equatable.dart';
import 'package:vitalytics/data/models/nutrition/nutrition_result.dart';

abstract class NutritionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NutritionInitial extends NutritionState {}

class NutritionLoading extends NutritionState {}

class NutritionLoaded extends NutritionState {
  final NutritionModel result;
  final List<Nutritions> filteredFoods;
  final String selectedCategory;
  final String searchQuery;

  NutritionLoaded({
    required this.result,
    required this.filteredFoods,
    this.selectedCategory = "All",
    this.searchQuery = "",
  });

  NutritionLoaded copyWith({
    NutritionModel? result,
    List<Nutritions>? filteredFoods,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return NutritionLoaded(
      result: result ?? this.result,
      filteredFoods: filteredFoods ?? this.filteredFoods,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props =>
      [result, filteredFoods, selectedCategory, searchQuery];
}

class NutritionError extends NutritionState {
  final String message;
  NutritionError(this.message);

  @override
  List<Object?> get props => [message];
}
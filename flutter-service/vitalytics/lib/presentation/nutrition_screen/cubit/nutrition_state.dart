import '../models/food_item.dart';

abstract class NutritionState {}

class NutritionLoading extends NutritionState {}

class NutritionLoaded extends NutritionState {
  final List<FoodItem> allFoods;
  final List<FoodItem> filteredFoods;
  final String selectedCategory;
  final String searchQuery;

  NutritionLoaded({
    required this.allFoods,
    required this.filteredFoods,
    this.selectedCategory = "All",
    this.searchQuery = "",
  });

  NutritionLoaded copyWith({
    List<FoodItem>? allFoods,
    List<FoodItem>? filteredFoods,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return NutritionLoaded(
      allFoods: allFoods ?? this.allFoods,
      filteredFoods: filteredFoods ?? this.filteredFoods,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

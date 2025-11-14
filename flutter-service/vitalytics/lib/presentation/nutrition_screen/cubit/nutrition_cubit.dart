import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/food_item.dart';
import 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionLoading()) {
    loadFoods();
  }

  void loadFoods() {
    final List<FoodItem> foods = [
      FoodItem(name: "Avocado", subtitle: "Hydration & Elasticity", category: "Fruits", image: "assets/avocado.png"),
      FoodItem(name: "Blueberries", subtitle: "Rich in Antioxidants", category: "Fruits", image: "assets/blueberries.png"),
      FoodItem(name: "Salmon", subtitle: "Omega-3 Power", category: "Healthy Protein", image: "assets/salmon.png"),
      FoodItem(name: "Walnuts", subtitle: "Boosts Collagen", category: "Healthy Protein", image: "assets/walnuts.png"),
      FoodItem(name: "Spinach", subtitle: "Vitamin Rich", category: "Vegetables", image: "assets/spinach.png"),
      FoodItem(name: "Sweet Potatoes", subtitle: "Beta-Carotene Source", category: "Vegetables", image: "assets/sweet_potato.png"),
      FoodItem(name: "Broccoli", subtitle: "Skin Detox", category: "Vegetables", image: "assets/broccoli.png"),
      FoodItem(name: "Green Tea", subtitle: "Reduces Redness", category: "Healthy Drinks", image: "assets/tea.png"),
    ];

    emit(NutritionLoaded(allFoods: foods, filteredFoods: foods));
  }

  void filterByCategory(String category) {
    final current = state as NutritionLoaded;
    final filtered = category == "All"
        ? current.allFoods
        : current.allFoods.where((item) => item.category == category).toList();

    emit(current.copyWith(
      selectedCategory: category,
      filteredFoods: filtered,
    ));
  }

  void search(String query) {
    final current = state as NutritionLoaded;

    final filtered = current.allFoods.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(current.copyWith(
      searchQuery: query,
      filteredFoods: filtered,
    ));
  }
}

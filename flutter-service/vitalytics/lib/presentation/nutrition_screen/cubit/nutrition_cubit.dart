import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vitalytics/core/constants/api_endpoints.dart';
import 'package:vitalytics/core/network/dio_client.dart';
import 'package:vitalytics/data/models/nutrition/nutrition_result.dart';
import 'nutrition_state.dart';
import 'dart:developer';

class NutritionCubit extends Cubit<NutritionState> {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  // Corrected Constructor: Just initialize the state
  NutritionCubit() : super(NutritionInitial());

  // -----------------------------
  // 1️⃣ FETCH NUTRITION DATA
  // -----------------------------
  Future<void> fetchNutritions(int userId, String diseaseType) async {
    emit(NutritionLoading());

    try {
      final reqBody = {
        "user_id": userId.toString(),
        "disease_type": diseaseType,
        "query": "string" // Note: You may want to make this dynamic too
      };

      final response = await _dioClient.post(
        ApiEndpoints.skinNutrition,
        data: reqBody,
      );

      if (response.statusCode == 200) {
        final result = NutritionModel.fromJson(response.data);

        emit(
          NutritionLoaded(
            result: result,
            // Provide a default empty list if nutritions is null
            filteredFoods: result.nutritions ?? [],
            selectedCategory: "All",
          ),
        );
      } else {
        emit(NutritionError("Unexpected server response"));
      }
    } catch (e) {
      log("Error fetching nutrition: $e"); // Use log for better debugging
      emit(NutritionError(e.toString()));
    }
  }

  // -----------------------------
  // 2️⃣ SEARCH
  // -----------------------------
  void search(String query) {
    // Ensure we are in the loaded state
    final currentState = state;
    if (currentState is! NutritionLoaded) return;

    // Get the original list from the result, which might be null
    final originalList = currentState.result.nutritions;

    // Default to an empty list if the original list is null
    final results = (originalList ?? []).where((item) {
      final q = query.toLowerCase();

      // Safely check name, defaulting to false if null
      final nameMatch = item.name?.toLowerCase().contains(q) ?? false;
      
      // Safely check benefit, defaulting to false if null
      final benefitMatch = item.benefit?.toLowerCase().contains(q) ?? false;

      return nameMatch || benefitMatch;
    }).toList();

    emit(currentState.copyWith(
      filteredFoods: results,
      searchQuery: query,
      selectedCategory: "All", // Reset category when searching
    ));
  }

  // -----------------------------
  // 3️⃣ FILTER CATEGORY
  // -----------------------------
  void filterByCategory(String category) {
    // Ensure we are in the loaded state
    final currentState = state;
    if (currentState is! NutritionLoaded) return;

    // Get the original list from the result, which might be null
    final items = currentState.result.nutritions;

    if (category == "All") {
      emit(currentState.copyWith(
        // Default to an empty list if items is null
        filteredFoods: items ?? [],
        selectedCategory: category,
      ));
      return;
    }

    // Default to an empty list if items is null
    final filtered = (items ?? []).where((item) {
      // Safely join sourceFoods, defaulting to an empty string if null
      final foodList = item.sourceFoods
          ?.join(" ")
          .toLowerCase() ?? "";

      return foodList.contains(category.toLowerCase());
    }).toList();

    emit(currentState.copyWith(
      filteredFoods: filtered,
      selectedCategory: category,
    ));
  }
}
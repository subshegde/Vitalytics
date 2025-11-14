// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalytics/data/request/nutrition_request.dart';
import 'package:vitalytics/presentation/nutrition_screen/cubit/nutrition_details_cubit.dart';
import 'package:vitalytics/presentation/nutrition_screen/cubit/nutrition_details_state.dart';

import '../../core/constants/app_colors.dart';


class NutritionDetailsPage extends StatelessWidget {
  final String name;
  final String diseaseType;
  final String query;

  const NutritionDetailsPage({
    super.key,
    required this.name,
    required this.diseaseType,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NutritionDetailsCubit()
        ..fetchNutritionDetails(
          NutritionRequest(
            name: name,
            diseaseType: diseaseType,
            query: query,
          ),
        ),
      child: Scaffold(
        backgroundColor: primeGreen950,
        appBar: AppBar(
          backgroundColor: primeGreen900,
          title: const Text(
            "Nutrition Details",
            style: TextStyle(color: primeText),
          ),
          iconTheme: const IconThemeData(color: primeText),
          elevation: 0,
        ),
        body: BlocBuilder<NutritionDetailsCubit, NutritionDetailsState>(
          builder: (context, state) {
            if (state is NutritionDetailsLoading) {
              return _loadingShimmer();
            }

            if (state is NutritionDetailsError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: const TextStyle(color: primeText),
                ),
              );
            }

            if (state is NutritionDetailsLoaded) {
              final item = state.data;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    item.itemName ?? "",
                    style: const TextStyle(
                      color: primeText,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    item.category ?? "",
                    style: const TextStyle(
                      color: primeTextDim,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    item.description ?? "",
                    style: const TextStyle(
                      color: primeText,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Key Nutrients",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: primeAccent,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...?item.keyNutrients?.map(
                    (n) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: primeGreen900,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          n.nutrient ?? "",
                          style: const TextStyle(
                            color: primeText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          n.amount ?? "",
                          style: const TextStyle(
                            color: primeTextDim,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Widget _loadingShimmer() {
  return ListView.builder(
    itemCount: 5,
    padding: const EdgeInsets.all(16),
    itemBuilder: (_, index) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 70,
      decoration: BoxDecoration(
        color: primeGreen900.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
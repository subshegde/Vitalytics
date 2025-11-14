import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/nutrition_cubit.dart';
import 'cubit/nutrition_state.dart';

class NutritionScreen extends StatelessWidget {
  final categories = [
    "All",
    "Fruits",
    "Vegetables",
    "Healthy Protein",
    "Healthy Drinks",
  ];

  NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NutritionCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1F17),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Skin Health Nutrition",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<NutritionCubit, NutritionState>(
          builder: (context, state) {
            if (state is NutritionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = state as NutritionLoaded;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Discover foods that help you achieve a healthy, radiant glow.",
                    style: TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(height: 16),

                  // Search bar
                  TextField(
                    onChanged: context.read<NutritionCubit>().search,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green.shade800,
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      hintText: "Search for specific foods",
                      hintStyle: const TextStyle(color: Colors.white60),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  // Category Chips
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) {
                        final selected = categories[i] == data.selectedCategory;

                        return GestureDetector(
                          onTap: () => context
                              .read<NutritionCubit>()
                              .filterByCategory(categories[i]),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: selected
                                  ? Colors.green
                                  : Colors.green.shade900,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              categories[i],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: data.filteredFoods.length,
                    itemBuilder: (context, index) {
                      final item = data.filteredFoods[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF16261E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

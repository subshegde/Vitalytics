import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vitalytics/presentation/nutrition_screen/nutrition_details.dart';
import 'cubit/nutrition_cubit.dart';
import 'cubit/nutrition_state.dart';
class NutritionScreen extends StatelessWidget {
  final int userId;
  final String diseaseType;

  const NutritionScreen({
    super.key,
    required this.userId,
    required this.diseaseType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NutritionCubit()..fetchNutritions(userId, diseaseType),
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
            if (state is NutritionInitial || state is NutritionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NutritionError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Failed to load nutrition data: ${state.message}",
                    style: const TextStyle(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (state is NutritionLoaded) {
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
                    
                    // Search Bar
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

                    // Nutrition Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5, // Kept aspect ratio
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: state.filteredFoods.length,
                      itemBuilder: (context, index) {
                        final item = state.filteredFoods[index];

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NutritionDetailsPage(
                                  name: item.name ?? "Unknown",
                                  diseaseType: diseaseType,
                                  query: "",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF16261E),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            // This Column was causing the overflow
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                // --- START FIX ---
                          
                                // Image Section
                                // 1. Wrapped image in Expanded
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: item.image ?? "",
                                      // 2. Removed fixed height
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, _) => Container(
                                        // height: 150, // Removed
                                        color: Colors.grey.shade900,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.transparent,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, error, stackTrace) =>
                                          Container(
                                        // height: 150, // Removed
                                        color: Colors.grey.shade800,
                                        child: const Icon(Icons.broken_image,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                          
                                // Text Section
                                // 3. Wrapped text area in Expanded
                                Expanded(
                                  flex: 1, // Give text 1/3 of the space
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Food Name
                                        Text(
                                          item.name ?? "Unnamed Food",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                          
                                        // Benefits
                                        Text(
                                          item.benefit ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                          
                                        if (item.sourceFoods != null)
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Wrap(
                                                spacing: 6,
                                                runSpacing: 4,
                                                children: item.sourceFoods!
                                                    .map(
                                                      (src) => Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 6,
                                                          vertical: 2,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .green.shade700,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                        ),
                                                        child: Text(
                                                          src,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: Text(
                "Something went wrong.",
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
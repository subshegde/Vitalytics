import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalytics/data/request/diet_request.dart';
import 'package:vitalytics/presentation/diet/cubit/diet_cubit.dart';
import 'package:vitalytics/presentation/diet/cubit/diet_state.dart';
import '../../core/constants/app_colors.dart';


class DietPage extends StatelessWidget {
  final String userId;
  final String diseaseType;
  final String query;

  const DietPage({
    super.key,
    required this.userId,
    required this.diseaseType,
    required this.query,
  });

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: primeGreen950,
    appBar: AppBar(
      backgroundColor: primeGreen900,
      elevation: 0,
      title: const Text(
        "Diet Recommendations",
        style: TextStyle(
          color: primeText,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: BlocBuilder<DietCubit, DietState>(
      builder: (context, state) {
        if (state is DietLoading) {
          return const Center(
            child: CircularProgressIndicator(color: primeAccent),
          );
        }

        if (state is DietError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }

        if (state is DietLoaded) {
          final diet = state.dietModel;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                _sectionTitle("Summary"),
                _cardContainer(
                  child: Text(
                    diet.summaryText ?? "",
                    style: const TextStyle(
                      color: primeText,
                      fontSize: 15.5,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (diet.macroBreakdown != null) ...[
                  _sectionTitle("Macro Breakdown"),
                  _cardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _macroTile("Carbs", diet.macroBreakdown!.carbs),
                        _macroTile("Protein", diet.macroBreakdown!.protein),
                        _macroTile("Fats", diet.macroBreakdown!.fats),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                _sectionTitle("Recommendations"),
                if (diet.recommendations != null)
                  ...diet.recommendations!.map(
                    (item) => _recommendationTile(item),
                  ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    ),
  );
}

  // -------------------------------------------------------------
  // UI HELPERS
  // -------------------------------------------------------------

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: primeText,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _cardContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primeGreen900,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primeAccent.withOpacity(0.15), width: 1),
      ),
      child: child,
    );
  }

  Widget _macroTile(String title, int? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: primeTextDim,
              fontSize: 16,
            ),
          ),
          Text(
            "${value ?? 0} g",
            style: const TextStyle(
              color: primeAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendationTile(String recommendation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: primeGreen900,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primeAccent.withOpacity(0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: primeAccent,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              recommendation,
              style: const TextStyle(
                color: primeText,
                fontSize: 15.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

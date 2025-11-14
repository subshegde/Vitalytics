import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/data/db/disease_detection_dao.dart';
import 'package:vitalytics/data/models/disease_detection/disease_detection_model.dart';
import 'package:vitalytics/data/models/suggestion/suggestion_result.dart';
import 'package:vitalytics/presentation/dashboard/pages/analysis_page.dart'
    hide primeGreen900, primeAccent, primeText, primeGreen950;
import 'package:vitalytics/sl.dart';

import '../cubit/hemeo_cub.dart';
import '../cubit/recomend_state.dart';
import '../cubit/recomendation_cubit.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {

  final Widget homeSolutions = _buildHomeAndNaturalSolutions();


  @override
  void initState() {
    super.initState();
    _loadLastDetection();
  }

  DiseaseDetectionModel? lastDetection;
  bool isLoading = true;

  Future<void> _loadLastDetection() async {
    final prefs = sl<SharedPreferences>();
    final userId = prefs.getInt('logged_in_user_id');
    final dao = DiseaseDetectionDao();
    final allDiseases = await dao.getDiseasesByUser(userId ?? 0);

    if (allDiseases.isNotEmpty) {
      setState(() {
        // Show the last inserted record
        lastDetection = allDiseases.last;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primeGreen950,

        // ----------------------------------------------------------
        // APP BAR (matches theme)
        // ----------------------------------------------------------
        appBar: AppBar(
          backgroundColor: primeGreen950,
          scrolledUnderElevation: 0,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: primeAccent),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Recommendations',
            style: TextStyle(color: primeText, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),

        body: NestedScrollView(
          headerSliverBuilder: (context, inner) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primeGreen900,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primeGreen700.withOpacity(0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Last Detection Result",
                        style: TextStyle(
                          color: primeText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Disease: ${lastDetection?.detected_disease ?? ""}",
                        style: const TextStyle(color: primeTextDim, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Confidence: ${(lastDetection?.confidence_score ?? 0 * 100).toStringAsFixed(1)}%",
                        style: const TextStyle(color: primeTextDim, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Description: ${lastDetection?.description ?? ""}",
                        style: const TextStyle(color: primeTextDim, fontSize: 16),
                      ),
                      const SizedBox(height: 4),

                      // FIX PRECaution List
                      if ((lastDetection?.precautionary_steps ?? []).isNotEmpty) ...[
                        const Text(
                          "Precautionary Steps:",
                          style: TextStyle(
                            color: primeText,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ...(lastDetection?.precautionary_steps ?? []).map(
                              (step) => Text(
                            "• $step",
                            style: const TextStyle(
                              color: primeTextDim,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),

              // -----------------------------------------
              // TOP HEADER (Disclaimer + Nutrition Button)
              // -----------------------------------------
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------------- DISCLAIMER BOX ----------------
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: primeGreen900,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: primeGreen700.withOpacity(0.4),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: primeAccent,
                              size: 26,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Disclaimer',
                                    style: TextStyle(
                                      color: primeText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'These are suggestions. Please consult a qualified doctor before starting any treatment.',
                                    style: TextStyle(
                                      color: primeTextDim,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // const SizedBox(height: 16),

                      // // ---------------- NUTRITION BUTTON ----------------
                      // ElevatedButton.icon(
                      //   icon: const Icon(Icons.search, size: 22),
                      //   label: const Text('Skin Health Nutrition'),
                      //   onPressed: () {},
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: primeAccent,
                      //     foregroundColor: primeGreen950,
                      //     padding: const EdgeInsets.symmetric(vertical: 16),
                      //     textStyle: const TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 16,
                      //     ),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(28),
                      //     ),
                      //     minimumSize: const Size(double.infinity, 54),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),

              // ---------------------------------------------------------
              // TAB BAR (STICKY, themed background)
              // ---------------------------------------------------------
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    isScrollable: true,
                    labelColor: primeAccent,
                    unselectedLabelColor: primeTextDim,
                    indicatorColor: primeAccent,
                    indicatorWeight: 3,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    tabs: const [

                      Tab(text: 'Medicines'),
                      Tab(text: 'Homeopathy'),

                    ],
                  ),
                ),
              ),
            ];
          },

          // ---------------------------------------------------------
          // TAB CONTENT
          // ---------------------------------------------------------
          body: TabBarView(
            children: [

              BlocConsumer<RecommendationCubit, RecommendationState>(
                listener: (_, state) {},
                builder: (context, state) {

                  if (state is RecommendationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is RecommendationLoaded) {
                    final medicines = state.data.items;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                      child: buildPharmaceuticalMedicines(
                        items: medicines,
                        onGenerate: () async {
                          final dao = DiseaseDetectionDao();
                          final prefs = sl<SharedPreferences>();
                          final userId = prefs.getInt('logged_in_user_id') ?? 0;

                          final diseases = await dao.getDiseasesByUser(userId);
                          final lastDisease = diseases.isNotEmpty
                              ? diseases.last.detected_disease
                              : "";

                          context
                              .read<RecommendationCubit>()
                              .fetchRecommendations(userId, lastDisease, "medicine");
                        },
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                    child: buildPharmaceuticalMedicines(
                      items: [],
                      onGenerate: () async {
                        final prefs = sl<SharedPreferences>();
                        final userId = prefs.getInt('logged_in_user_id') ?? 0;
                        final dao = DiseaseDetectionDao();
                        final diseases = await dao.getDiseasesByUser(userId);

                        final diseaseName = diseases.isNotEmpty
                            ? diseases.last.detected_disease
                            : "";

                        context
                            .read<RecommendationCubit>()
                            .fetchRecommendations(userId, diseaseName, "medicine");
                      },
                    ),
                  );
                },
              ),


              BlocConsumer<HomeopathyRecommendationCubit, RecommendationState>(
                listener: (_, __) {},
                builder: (context, state) {

                  if (state is RecommendationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is RecommendationLoaded) {
                    final items = state.data.items;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                      child: buildHomeopathicSection(
                        items: items,
                        onGenerate: () async {
                          final prefs = sl<SharedPreferences>();
                          final userId = prefs.getInt('logged_in_user_id') ?? 0;

                          final dao = DiseaseDetectionDao();
                          final diseases = await dao.getDiseasesByUser(userId);
                          final diseaseName =
                          diseases.isNotEmpty ? diseases.last.detected_disease : "";

                          context
                              .read<HomeopathyRecommendationCubit>()
                              .fetchHomeopathyRecommendations(userId, diseaseName);
                        },
                      ),
                    );
                  }

                  // INITIAL + ERROR CASE
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                    child: buildHomeopathicSection(
                      items: [],
                      onGenerate: () async {
                        final prefs = sl<SharedPreferences>();
                        final userId = prefs.getInt('logged_in_user_id') ?? 0;

                        final dao = DiseaseDetectionDao();
                        final diseases = await dao.getDiseasesByUser(userId);
                        final diseaseName =
                        diseases.isNotEmpty ? diseases.last.detected_disease : "";

                        context
                            .read<HomeopathyRecommendationCubit>()
                            .fetchHomeopathyRecommendations(userId, diseaseName);
                      },
                    ),
                  );
                },
              )





            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // SECTION BUILDERS
  // ------------------------------
  static Widget buildPharmaceuticalMedicines({
    required List<Map<String, dynamic>> items,
    required VoidCallback onGenerate,
  }) {
    return _StyledExpansionTile(
      title: 'Medicines',
      initiallyExpanded: true,
      children: [
        if (items.isEmpty)
          Column(
            children: [
              const Text(
                "No recommendations available",
                style: TextStyle(color: primeTextDim, fontSize: 14),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onGenerate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primeAccent,
                  foregroundColor: primeGreen950,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Generate Recommendations"),
              ),
            ],
          )
        else
          ...items.map((mapItem) {
            return _RecommendationItem(
              icon: Icons.medication_liquid_outlined,
              title: mapItem["name"] ?? "",
              subtitle:
              "${mapItem["dosage"] ?? ""}\n\n${mapItem["note"] ?? ""}",
            );
          }).toList(),
      ],
    );
  }




  static Widget _buildHomeAndNaturalSolutions() {
    return _StyledExpansionTile(
      title: 'Home & Natural Solutions',
      children: [
        _RecommendationItem(
          icon: Icons.eco_outlined,
          title: 'Oatmeal Bath',
          subtitle: 'Colloidal oatmeal can soothe irritated skin.',
        ),
        _RecommendationItem(
          icon: Icons.spa_outlined,
          title: 'Aloe Vera Gel',
          subtitle: 'Provides a cooling effect and reduces inflammation.',
        ),
      ],
    );
  }

  static Widget buildHomeopathicSection({
    required List<Map<String, dynamic>> items,
    required VoidCallback onGenerate,
  }) {
    return _StyledExpansionTile(
      title: 'Homeopathic Remedies',
      initiallyExpanded: true,
      children: [
        if (items.isEmpty)
          Column(
            children: [
              const Text(
                "No recommendations available",
                style: TextStyle(color: primeTextDim, fontSize: 14),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: onGenerate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primeAccent,
                  foregroundColor: primeGreen950,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Generate Recommendations"),
              ),
            ],
          )
        else
          ...items.map((mapItem) {
            return _RecommendationItem(
              icon: Icons.grass_outlined,
              title: mapItem["name"] ?? "",
              subtitle:
              "${mapItem["dosage"] ?? ""}\n\n${mapItem["note"] ?? ""}",
            );
          }).toList(),
      ],
    );
  }

}

// ============================================================================
// STYLED EXPANSION TILE (THEME APPLIED)
// ============================================================================
class _StyledExpansionTile extends StatelessWidget {
  final String title;
  final bool initiallyExpanded;
  final List<Widget> children;

  const _StyledExpansionTile({
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 12),
      collapsedIconColor: primeTextDim,
      iconColor: primeAccent,
      initiallyExpanded: initiallyExpanded,

      backgroundColor: primeGreen900,
      collapsedBackgroundColor: primeGreen900,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: primeText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      children: children,
    );
  }
}

// ============================================================================
// LIST ITEM WIDGET (THEMED GREEN STYLE)
// ============================================================================
class _RecommendationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _RecommendationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            // Icon Box
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primeGreen950,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primeAccent, size: 22),
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: primeText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(color: primeTextDim, height: 1.4),
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16, color: primeTextDim),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// TAB BAR DELEGATE (STICKY TAB BAR, THEMED BG)
// ============================================================================
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrink, bool overlaps) {
    return Container(color: primeGreen950, child: tabBar);
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/data/db/disease_detection_dao.dart';
import 'package:vitalytics/data/models/disease_detection/disease_detection_model.dart';
import 'package:vitalytics/presentation/dashboard/pages/analysis_page.dart'
    hide primeGreen900, primeAccent, primeText, primeGreen950;
import 'package:vitalytics/sl.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  final Widget pharmaMedicines = _buildPharmaceuticalMedicines();
  final Widget homeSolutions = _buildHomeAndNaturalSolutions();
  final Widget homeopathicRemedies = _buildHomeopathicRemedies();

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
      length: 4,
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
              Container(
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
                      "Disease: ${lastDetection!.detected_disease}",
                      style: const TextStyle(color: primeTextDim, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Confidence: ${(lastDetection!.confidence_score * 100).toStringAsFixed(1)}%",
                      style: const TextStyle(color: primeTextDim, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Description: ${lastDetection!.description}",
                      style: const TextStyle(color: primeTextDim, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    if (lastDetection!.precautionary_steps.isNotEmpty) ...[
                      const Text(
                        "Precautionary Steps:",
                        style: TextStyle(
                          color: primeText,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...lastDetection!.precautionary_steps.map(
                        (step) => Text(
                          "• $step",
                          style: const TextStyle(
                            color: primeTextDim,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ],
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
                      Tab(text: 'All'),
                      Tab(text: 'Medicines'),
                      Tab(text: 'Homeopathy'),
                      Tab(text: 'Home Solutions'),
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
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                children: [
                  pharmaMedicines,
                  const SizedBox(height: 16),
                  homeSolutions,
                  const SizedBox(height: 16),
                  homeopathicRemedies,
                ],
              ),

              ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                children: [pharmaMedicines],
              ),

              ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                children: [homeopathicRemedies],
              ),

              ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                children: [homeSolutions],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // SECTION BUILDERS
  // ------------------------------
  static Widget _buildPharmaceuticalMedicines() {
    return _StyledExpansionTile(
      title: 'Pharmaceutical Medicines',
      initiallyExpanded: true,
      children: [
        _RecommendationItem(
          icon: Icons.medication_liquid_outlined,
          title: 'Hydrocortisone Cream',
          subtitle: 'Topical cream for reducing inflammation and itching.',
        ),
        _RecommendationItem(
          icon: Icons.medical_services_outlined,
          title: 'Antihistamines',
          subtitle: 'Oral medication to help control itching.',
        ),
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

  static Widget _buildHomeopathicRemedies() {
    return _StyledExpansionTile(
      title: 'Homeopathic Remedies',
      children: [
        _RecommendationItem(
          icon: Icons.grass_outlined,
          title: 'Sulphur',
          subtitle: 'Often recommended for chronic cases with intense itching.',
        ),
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

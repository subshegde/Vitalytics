// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/data/models/discover_item.dart';
import 'package:vitalytics/data/models/skin_care_tip_model.dart';
import 'package:vitalytics/data/models/user/user.dart';
import 'package:vitalytics/data/dao/user_dao.dart';
import 'package:vitalytics/presentation/dashboard/pages/analysis_page.dart';
import 'package:vitalytics/presentation/dashboard/pages/profile_page.dart';
import 'package:vitalytics/presentation/dashboard/pages/recommendation.dart';

import '../../../sl.dart';
import '../../nutrition_screen/nutrition_screen.dart';
import '../../progress_screen/progress_screen.dart';
import '../cubit/hemeo_cub.dart';
import '../cubit/recomendation_cubit.dart';

// THEME COLORS
const Color primeGreen950 = Color(0xFF0a2e26);
const Color primeGreen900 = Color(0xFF114232);
const Color primeAccent = Color(0xFF00f08c);
const Color primeText = Color(0xFFe0f2e9);
const Color primeTextDim = Color(0xFFa0b5ab);

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({super.key});

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  int _selectedIndex = 0;
  User? _loggedInUser;
  final UserDao _userDao = UserDao();

  final List<SkinCareTip> _skinCareTips = [
    SkinCareTip(
      title: '5 Tips for Sun Protection',
      subtitle: 'Protect your skin from UV.',
      imageUrl:
          'https://placehold.co/300x200/FEBD59/1E3923.png?text=Sun+Protection',
    ),
    SkinCareTip(
      title: 'Understanding Acne',
      subtitle: 'Causes, symptoms, treatments.',
      imageUrl:
          'https://placehold.co/300x200/D9E2DE/1E3923.png?text=Skin+Texture',
    ),
    SkinCareTip(
      title: 'Hydration is Key',
      subtitle: 'Why water matters for skin.',
      imageUrl: 'https://placehold.co/300x200/58A4B0/1E3923.png?text=Hydration',
    ),
  ];

  final List<DiscoverItem> _discoverItems = [
    DiscoverItem(
      title: 'Conditions',
      imageUrl:
          'https://placehold.co/200x200/D9E2DE/1E3923.png?text=Conditions',
    ),
    DiscoverItem(
      title: 'Remedies',
      imageUrl: 'https://placehold.co/200x200/C4B2A8/1E3923.png?text=Remedies',
    ),
    DiscoverItem(
      title: 'Prevention',
      imageUrl:
          'https://placehold.co/200x200/D8C5A2/1E3923.png?text=Prevention',
    ),
    DiscoverItem(
      title: 'Routines',
      imageUrl: 'https://placehold.co/200x200/A8C4B8/1E3923.png?text=Routines',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadLoggedInUser();
  }

  // ---------------- LOAD LOGGED-IN USER -----------------
  Future<void> _loadLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('logged_in_user_id');
    if (userId != null) {
      final user = await _userDao.getUserById(userId);
      setState(() {
        _loggedInUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeGreen950,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 32),
              _buildSectionTitle("Skin Care Tips"),
              const SizedBox(height: 16),
              _buildSkinCareTipsList(context),
              const SizedBox(height: 32),
              _buildSectionTitle("Discover More"),
              const SizedBox(height: 16),
              _buildDiscoverGrid(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- APP BAR -----------------
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (_loggedInUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePage(userId: _loggedInUser!.id ?? 0),
                  ),
                );
              }
            },
            child: CircleAvatar(
              radius: 26,
              backgroundImage: _loggedInUser?.profilePicPath != null
                  ? FileImage(File(_loggedInUser!.profilePicPath!))
                  : const NetworkImage(
                          'https://placehold.co/100x100/A8C4B8/1E3923.png?text=Alex',
                        )
                        as ImageProvider,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,",
                style: TextStyle(color: primeTextDim, fontSize: 16),
              ),
              Text(
                _loggedInUser?.username ?? "Guest",
                style: TextStyle(
                  color: primeText,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_loggedInUser?.email != null)
                Text(
                  _loggedInUser!.email!,
                  style: TextStyle(color: primeTextDim, fontSize: 14),
                ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined, size: 30),
            color: primeAccent,
          ),
        ],
      ),
    );
  }

  // ---------------- QUICK ACTIONS -----------------
  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _quickAction(
            context,
            icon: Icons.document_scanner_outlined,
            label: "New Scan",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnalysisPage()),
            ),
          ),
          _quickAction(
            context,
            icon: Icons.recommend_outlined,
            label: "Recommendation",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => RecommendationCubit()),
                    BlocProvider(
                      create: (_) => HomeopathyRecommendationCubit(),
                    ),
                  ],
                  child: const RecommendationsScreen(),
                ),
              ),
            ),
          ),
          _quickAction(
            context,
            icon: Icons.spa_outlined,
            label: "Nutritions",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NutritionScreen()),
            ),
          ),
          _quickAction(
            context,
            icon: Icons.history_outlined,
            label: "Progress Tracking",
            onTap: () {
              final prefs = sl<SharedPreferences>();
              final userId = prefs.getInt('logged_in_user_id');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullProgressScreen(userId: userId ?? 0, base64Image: '',),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _quickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: primeAccent, size: 30),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: primeTextDim, fontSize: 13)),
        ],
      ),
    );
  }

  // ---------------- SECTION TITLE -----------------
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          color: primeText,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ---------------- TIPS HORIZONTAL LIST -----------------
  Widget _buildSkinCareTipsList(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.65;
    final cardHeight = cardWidth * 0.8;

    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _skinCareTips.length,
        itemBuilder: (context, i) {
          return _tipCard(_skinCareTips[i], cardWidth, cardHeight);
        },
      ),
    );
  }

  Widget _tipCard(SkinCareTip tip, double width, double height) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Clicked: ${tip.title}")));
      },
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: primeGreen900,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(tip.imageUrl, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      primeGreen950.withOpacity(0.75),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tip.title,
                      style: TextStyle(
                        color: primeText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tip.subtitle,
                      style: TextStyle(color: primeTextDim, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- DISCOVER GRID -----------------
  Widget _buildDiscoverGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _discoverItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, i) => _discoverCard(_discoverItems[i]),
      ),
    );
  }

  Widget _discoverCard(DiscoverItem item) {
    return InkWell(
      onTap: () {
        // ScaffoldMessenger.of(context) .showSnackBar(SnackBar(content: Text("Clicked: ${item.title}")));
      },
      child: Container(
        decoration: BoxDecoration(
          color: primeGreen900,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(item.imageUrl, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      primeGreen950.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: primeText,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

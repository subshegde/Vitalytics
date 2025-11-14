// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/presentation/dashboard/cubit/analysis_page_cubit.dart';
import 'package:vitalytics/presentation/dashboard/cubit/analysis_page_state.dart';
import 'package:vitalytics/presentation/dashboard/cubit/hemeo_cub.dart';
import 'package:vitalytics/presentation/dashboard/pages/recommendation.dart';
import 'package:vitalytics/presentation/progress_screen/progress_screen.dart';
import 'package:vitalytics/sl.dart';
import 'package:image/image.dart' as img;

import '../cubit/recomendation_cubit.dart';

/// ------------------------------
/// THEME COLORS
/// ------------------------------
const Color primeGreen950 = Color(0xFF0D1F12);
const Color primeGreen900 = Color(0xFF14331D);
const Color primeGreen700 = Color(0xFF1F5A33);
const Color primeGreen600 = Color(0xFF2B6F40);
const Color primeAccent = Color(0xFF52FFA8);
const Color primeText = Colors.white;

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int? userId;

  bool isReadyToAnalyze = false; // <— FIXED

  @override
  void initState() {
    super.initState();
    _loadLoggedInUser();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  Future<void> _loadLoggedInUser() async {
    final prefs = sl<SharedPreferences>();
    setState(() {
      userId = prefs.getInt('logged_in_user_id');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _openPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: primeGreen900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Image Source",
                  style: TextStyle(
                    color: primeText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(Icons.camera_alt, color: primeAccent),
                  title: const Text("Camera", style: TextStyle(color: primeText)),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (picked != null) {
                      context.read<AnalysisCubit>().selectImage(File(picked.path));
                    }
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.photo_library, color: primeAccent),
                  title: const Text("Gallery", style: TextStyle(color: primeText)),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) {
                      context.read<AnalysisCubit>().selectImage(File(picked.path));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnalysisCubit(),
      child: Scaffold(
        backgroundColor: primeGreen950,
        appBar: AppBar(
          backgroundColor: primeGreen900,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: primeAccent),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Skin Analysis",
              style: TextStyle(color: primeText, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),

        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: BlocConsumer<AnalysisCubit, AnalysisState>(
                listener: (context, state) {
                  if (state is AnalysisError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message,
                            style: const TextStyle(color: Colors.white)),
                        backgroundColor: primeGreen700,
                      ),
                    );
                  } else if (state is AnalysisUploaded) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider(create: (_) => RecommendationCubit()),
                            BlocProvider(create: (_) => HomeopathyRecommendationCubit()),
                          ],
                          child: const RecommendationsScreen(),
                        ),
                      ),
                    );
                  }
                },

                builder: (context, state) {
                  File? image;

                  if (state is AnalysisImageSelected) {
                    image = state.image;
                    isReadyToAnalyze = true; // <— FIX
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DottedBorder(
                        color: primeAccent.withOpacity(0.7),
                        dashPattern: const [8, 6],
                        strokeWidth: 2,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        padding: const EdgeInsets.all(24),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primeGreen900.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Text(
                                "Upload Photo for Analysis",
                                style: TextStyle(
                                  color: primeText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),

                              const Text(
                                "Use a clear, well-lit image for best accuracy.",
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),

                              if (image != null) ...[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    image,
                                    width: double.infinity,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 22),
                              ],

                              ElevatedButton.icon(
                                onPressed: () => _openPickerOptions(context),
                                icon: const Icon(Icons.upload, color: primeText),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primeGreen600,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                label: const Text("Upload Photo",
                                    style: TextStyle(color: primeText)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      if (isReadyToAnalyze)
                        Column(
                          children: [
                            if (state is AnalysisLoading)
                              const LinearProgressIndicator(),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                /// ANALYZE BUTTON FIXED
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: (state is AnalysisLoading)
                                        ? null
                                        : () {
                                            setState(() {}); // important
                                            context.read<AnalysisCubit>().uploadImage(
                                                  userId: userId?.toString() ?? "",
                                                );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primeGreen600,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "Analyze",
                                      style: TextStyle(color: primeText),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final file = image;
                                      if (file == null) return;

                                      final bytes = await file.readAsBytes();
                                      final decoded = img.decodeImage(bytes);
                                      final compressed =
                                          img.encodeJpg(decoded!, quality: 70);
                                      final base64Image =
                                          base64Encode(compressed);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FullProgressScreen(
                                            userId: userId ?? 0,
                                            base64Image: base64Image,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primeAccent,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "Progress",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      const SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: primeGreen900.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: primeGreen700.withOpacity(0.3)),
                        ),
                        child: const Text(
                          "This is not a medical diagnosis. Consult a healthcare professional for accurate assessment.",
                          style: TextStyle(color: Colors.white70, height: 1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 50),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

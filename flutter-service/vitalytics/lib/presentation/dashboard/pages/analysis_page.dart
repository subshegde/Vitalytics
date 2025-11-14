// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/presentation/dashboard/cubit/analysis_page_cubit.dart';
import 'package:vitalytics/presentation/dashboard/cubit/analysis_page_state.dart';
import 'package:vitalytics/sl.dart';

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
                  title: const Text(
                    "Camera",
                    style: TextStyle(color: primeText),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (picked != null) {
                      context.read<AnalysisCubit>().selectImage(
                        File(picked.path),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Photo captured successfully!",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: primeGreen700,
                        ),
                      );
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: primeAccent),
                  title: const Text(
                    "Gallery",
                    style: TextStyle(color: primeText),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) {
                      context.read<AnalysisCubit>().selectImage(
                        File(picked.path),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Photo selected successfully!",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: primeGreen700,
                        ),
                      );
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

  int? userId;
  Future<void> _loadLoggedInUser() async {
    final prefs = sl<SharedPreferences>();
    userId = prefs.getInt('logged_in_user_id');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnalysisCubit(),
      child: Scaffold(
        backgroundColor: primeGreen950,
        appBar: AppBar(
          backgroundColor: primeGreen900,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: primeAccent,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Skin Analysis",
            style: TextStyle(color: primeText, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BlocConsumer<AnalysisCubit, AnalysisState>(
                listener: (context, state) {
                  if (state is AnalysisError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: primeGreen700,
                      ),
                    );
                  } else if (state is AnalysisUploaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Analysis successful!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: primeGreen700,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  File? image;
                  if (state is AnalysisImageSelected) image = state.image;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      DottedBorder(
                        color: primeAccent.withOpacity(0.7),
                        strokeWidth: 2,
                        dashPattern: const [8, 6],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primeGreen900.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Upload Photo for Analysis',
                                style: TextStyle(
                                  color: primeText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'For best results, use a clear, well-lit image.',
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),

                              // SHOW SELECTED IMAGE
                              if (image != null) ...[
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.file(
                                        image,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () => context
                                            .read<AnalysisCubit>()
                                            .removeImage(),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.5,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],

                              // UPLOAD BUTTON
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primeGreen600,
                                  foregroundColor: primeText,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => _openPickerOptions(context),
                                icon: const Icon(Icons.upload_file_rounded),
                                label: const Text('Upload Photo'),
                              ),

                              const SizedBox(height: 24),
                              const Text(
                                'Your privacy is important. All images are processed securely.',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      if (state is AnalysisImageSelected ||
                          state is AnalysisLoading)
                        Column(
                          children: [
                            if (state is AnalysisLoading)
                              const LinearProgressIndicator(),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: state is AnalysisLoading
                                  ? null
                                  : () => context
                                        .read<AnalysisCubit>()
                                        .uploadImage(userId: userId.toString()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primeGreen600,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 32,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Analyze",
                                style: TextStyle(color: primeText),
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 16),

                      // DISCLAIMER
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: primeGreen900.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: primeGreen700.withOpacity(0.4),
                          ),
                        ),
                        child: const Text(
                          'This is not a medical diagnosis. Please consult a healthcare professional for an accurate assessment.',
                          style: TextStyle(color: Colors.white70, height: 1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
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

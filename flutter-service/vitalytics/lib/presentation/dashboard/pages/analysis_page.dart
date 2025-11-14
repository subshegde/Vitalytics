// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

/// ----------------------
/// THEME COLOR CONSTANTS
/// ----------------------
const Color primeGreen950 = Color(0xFF0D1F12);
const Color primeGreen900 = Color(0xFF14331D);
const Color primeGreen700 = Color(0xFF1F5A33);
const Color primeGreen600 = Color(0xFF2B6F40);
const Color primeGreen500 = Color(0xFF3B8B54);
const Color primeAccent   = Color(0xFF52FFA8);
const Color primeText     = Colors.white;

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

  void _uploadPhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Upload feature coming soon!'),
        backgroundColor: primeGreen700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeGreen950,

      // ---------------------------
      // THEMED APPBAR
      // ---------------------------
      appBar: AppBar(
        backgroundColor: primeGreen900,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: primeAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Skin Analysis",
          style: TextStyle(color: primeText, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      // ---------------------------
      // PAGE BODY
      // ---------------------------
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // ------------------------------------------------
                //   UPLOAD PHOTO BOX WITH THEME COLORS
                // ------------------------------------------------
                DottedBorder(
                  color: primeAccent.withOpacity(0.7),
                  strokeWidth: 2,
                  dashPattern: const [8, 6],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(20),
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
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
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'For best results, use a clear, well-lit image.',
                          style: TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

                        // ---------------------------
                        // THEMED ELEVATED BUTTON
                        // ---------------------------
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primeGreen600,
                            foregroundColor: primeText,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _uploadPhoto,
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

                // ---------------------------
                // DISCLAIMER BOX (THEMED)
                // ---------------------------
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
            ),
          ),
        ),
      ),
    );
  }
}

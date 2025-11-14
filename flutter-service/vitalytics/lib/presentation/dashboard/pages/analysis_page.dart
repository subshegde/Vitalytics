import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart'; // Import the package

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
    // Set up the animation controller for the "dynamic" fade-in
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Placeholder function for upload logic
  void _uploadPhoto() {
    // Implement your image picker and analysis logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Upload functionality not implemented yet.'),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This page does NOT have its own Scaffold.
    // It's just the content that will be placed inside the MainPage's PageView.
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header Title
              Text(
                'Skin Health Analysis',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 2. Upload Box
              DottedBorder(
                color: Colors.white38,
                strokeWidth: 2,
                dashPattern: const [8, 6],
                borderType: BorderType.RRect,
                radius: const Radius.circular(20),
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Upload Photo for Analysis',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'For best results, use a clear, well-lit image.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _uploadPhoto,
                        icon: const Icon(Icons.upload_file_rounded),
                        label: const Text('Upload Photo'),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your privacy is important. All images are processed securely.',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white54, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(), // Pushes the disclaimer to the bottom

              // 3. Disclaimer
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'This is not a medical diagnosis. Please consult a healthcare professional for an accurate assessment.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
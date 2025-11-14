// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/presentation/dashboard/pages/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // State variable to track password visibility
  bool _isPasswordVisible = false;

  // Controllers to manage the text inside the TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Color constants from the image

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    // Logo Icon
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: primaryBlue.withOpacity(0.2),
                      child: const Icon(
                        Icons.eco_rounded,
                        color: primaryBlue,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Welcome Title
                    Text(
                      "Welcome Back",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      "Sign in to your account to continue.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- Username/Email Field ---
                    _buildLabel("Username or Email"),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration(
                        hintText: "yourname@email.com",
                        prefixIcon: Icons.person_outline,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Password Field ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_buildLabel("Password")],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      // This is the dynamic part:
                      // Toggle text visibility based on the _isPasswordVisible state
                      obscureText: !_isPasswordVisible,
                      decoration: _buildInputDecoration(
                        hintText: "Enter your password",
                        prefixIcon: Icons.lock_outline,
                        // Suffix icon to toggle password visibility
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: iconColor,
                          ),
                          onPressed: () {
                            // This is the dynamic logic:
                            // setState updates the UI when the variable changes
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- Sign In Button ---
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue, // Blue background
                        foregroundColor: Colors.white, // White text
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpPage(),
                              ),
                            );
                          },
                          child: const Text("Sign Up"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for building the text field labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w600),
    );
  }

  // Helper method for building the text field decoration
  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: formFieldBgColor,
      prefixIcon: Icon(prefixIcon, color: iconColor),
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: const TextStyle(color: hintColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // No border
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    );
  }
}

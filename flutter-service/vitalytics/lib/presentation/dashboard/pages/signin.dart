// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/data/dao/user_dao.dart';
import 'package:vitalytics/data/models/user/user.dart';
import 'package:vitalytics/presentation/dashboard/pages/signup.dart';
import 'package:vitalytics/presentation/dashboard/pages/skin_care_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // -------------------------------
  // COMPLETE LOGIN LOGIC
  // -------------------------------
  Future<void> _handleLogin() async {
    final emailOrUsername = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (emailOrUsername.isEmpty || password.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    // Fetch user using DAO
    User? user = await UserDao().getUserByEmailOrUsername(emailOrUsername);

    if (user == null) {
      _showMessage("User not found");
      return;
    }

    // ---- PASSWORD MATCH CHECK ----
    if (user.password != password) {
      _showMessage("Incorrect password");
      return;
    }

    // SUCCESS
    _showMessage("Login successful!");
    saveLoggedInUserId(user.id ?? 0, true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeDashboardPage()),
    );
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> saveLoggedInUserId(int userId, bool isLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('logged_in_user_id', userId);
    await prefs.setBool('isLogin', isLogin);
  }

  // -------------------------------
  // UI
  // -------------------------------
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

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

                    Text(
                      "Sign in to your account to continue.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // EMAIL / USERNAME
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

                    // PASSWORD
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_buildLabel("Password")],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: _buildInputDecoration(
                        hintText: "Enter your password",
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: iconColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
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

  // -------------------------------
  // UI Helpers
  // -------------------------------
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w600),
    );
  }

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
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    );
  }
}

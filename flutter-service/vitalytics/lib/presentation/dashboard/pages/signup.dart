import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vitalytics/data/dao/user_dao.dart';
import 'package:vitalytics/data/models/user/user.dart';
import 'package:vitalytics/presentation/dashboard/pages/signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // -------------------------------
  // SIGN UP LOGIC
  // -------------------------------
  Future<void> _handleSignUp() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validations
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    if (password != confirmPassword) {
      _showMessage("Passwords do not match");
      return;
    }

    // Check for existing email or username
    final userDao = UserDao();
    final existingUser =
        await userDao.getUserByEmailOrUsername(email) ??
        await userDao.getUserByEmailOrUsername(username);

    if (existingUser != null) {
      _showMessage("Username or email already exists");
      return;
    }

    // Create user object -- FIXED: password added
    final user = User(
      username: username,
      email: email,
      password: password,
      bio: '',
      profilePicPath: null,
    );

    // Insert user
    final userId = await userDao.insertUser(user);

    if (userId > 0) {
      _showMessage("Account created successfully!");

      Future.delayed(const Duration(milliseconds: 600), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      });
    } else {
      _showMessage("Something went wrong. Try again.");
    }
  }

  // Snackbar
  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // -------------------------------
  // UI
  // -------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Create Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Icon(
                Icons.spa_outlined,
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
              const SizedBox(height: 24),
              Text(
                'Create Your Account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                'Begin your journey to better skin health.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),

              // Username
              _buildTextField(
                label: "Username",
                hint: "Enter your username",
                controller: _usernameController,
              ),
              const SizedBox(height: 20),

              // Email
              _buildTextField(
                label: "Email",
                hint: "Enter your email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Password
              _buildTextField(
                label: "Password",
                hint: "Enter password",
                controller: _passwordController,
                isObscured: _isPasswordObscured,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () => setState(
                    () => _isPasswordObscured = !_isPasswordObscured,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Confirm password
              _buildTextField(
                label: "Confirm Password",
                hint: "Re-enter your password",
                controller: _confirmPasswordController,
                isObscured: _isConfirmPasswordObscured,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordObscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () => setState(
                    () => _isConfirmPasswordObscured =
                        !_isConfirmPasswordObscured,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Sign up button
              ElevatedButton(
                onPressed: _handleSignUp,
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 30),

              // Login redirect
              _buildLoginRedirect(),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------
  // Field Builder
  // -------------------------------
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isObscured = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscured,
          keyboardType: keyboardType,
          decoration: InputDecoration(hintText: hint, suffixIcon: suffixIcon),
        ),
      ],
    );
  }

  // -------------------------------
  // Login Redirect
  // -------------------------------
  Widget _buildLoginRedirect() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        children: [
          const TextSpan(text: "Already have an account? "),
          TextSpan(
            text: "Log In",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
          ),
        ],
      ),
    );
  }
}

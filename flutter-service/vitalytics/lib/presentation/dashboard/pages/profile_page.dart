import 'package:flutter/material.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/presentation/dashboard/pages/analysis_page.dart' hide primeText, primeGreen950, primeAccent, primeGreen900;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeGreen950,

      appBar: AppBar(
        backgroundColor: primeGreen950,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: primeAccent),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: primeText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),

                      _buildProfileAvatar(),

                      const SizedBox(height: 24),

                      // User Name
                      Text(
                        'Jordan Smith',
                        style: TextStyle(
                          fontSize: 24,
                          color: primeText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Email
                      const Text(
                        'jordan.smith@email.com',
                        style: TextStyle(
                          color: primeTextDim,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Username
                      const Text(
                        '@jordan_smith',
                        style: TextStyle(
                          color: primeTextDim,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  // -------- Avatar Widget ----------
  Widget _buildProfileAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: primeGreen900,
          child: const Icon(
            Icons.person_outline,
            size: 70,
            color: primeAccent,
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: primeAccent,
            child: IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  // -------- Logout Button ----------
  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout, color: Colors.black),
          label: const Text(
            'Log Out',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primeAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/data/dao/user_dao.dart';
import 'package:vitalytics/data/models/user/user.dart';
import 'package:vitalytics/presentation/dashboard/pages/signin.dart';

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User?> _futureUser;
  final UserDao _userDao = UserDao();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _futureUser = _userDao.getUserById(widget.userId);
  }

  // ------------ PICK IMAGE + SAVE + UPDATE DB ------------
  Future<void> _pickAndUpdateImage(User user) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return; // user cancelled

    // save image to app directory
    final directory = await getApplicationDocumentsDirectory();
    final fileName = path.basename(picked.path);
    final savedImage = File("${directory.path}/$fileName");
    await File(picked.path).copy(savedImage.path);

    // update database
    await _userDao.updateProfilePicturePath(user.id!, savedImage.path);

    // refresh UI
    setState(() {
      _futureUser = _userDao.getUserById(widget.userId);
    });
  }

  Future<void> clearAllPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeGreen950,
      appBar: AppBar(
        backgroundColor: primeGreen950,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primeAccent,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: primeText, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<User?>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: primeAccent),
              );
            }

            final user = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),

                        _buildProfileAvatar(user),

                        const SizedBox(height: 24),

                        Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 24,
                            color: primeText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          user.email,
                          style: const TextStyle(
                            color: primeTextDim,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          '@${user.username}',
                          style: const TextStyle(
                            color: primeTextDim,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 20),

                        if ((user.bio ?? "").isNotEmpty)
                          Text(
                            user.bio!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: primeText,
                              fontSize: 15,
                            ),
                          ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                _buildLogoutButton(),
              ],
            );
          },
        ),
      ),
    );
  }

  // -------- PROFILE AVATAR ----------
  Widget _buildProfileAvatar(User user) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: primeGreen900,
          backgroundImage: user.profilePicPath != null
              ? FileImage(File(user.profilePicPath!))
              : null,
          child: user.profilePicPath == null
              ? const Icon(Icons.person_outline, size: 70, color: primeAccent)
              : null,
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: primeAccent,
            child: IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.black),
              onPressed: () => _futureUser.then((u) => _pickAndUpdateImage(u!)),
            ),
          ),
        ),
      ],
    );
  }

  // -------- LOGOUT BUTTON ----------
  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            clearAllPrefs();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          },
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

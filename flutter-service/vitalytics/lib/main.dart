// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/presentation/dashboard/pages/signin.dart';
import 'package:vitalytics/presentation/dashboard/pages/skin_care_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final bool isLogin = prefs.getBool('isLogin') ?? false;

  runApp(VitalyticsApp(isLogin: isLogin));
}

class VitalyticsApp extends StatelessWidget {
  final bool isLogin;
  const VitalyticsApp({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Analysis',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,

        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: Colors.black,
          error: Colors.redAccent,
          onError: Colors.white,
          background: backgroundColor,
          onBackground: Colors.white,
          surface: cardColor,
          onSurface: Colors.white,
          tertiary: accentColor,
          onTertiary: Colors.black,
        ),

        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24.0,
          ),
          bodyLarge: TextStyle(
            color: Colors.white70,
            fontSize: 16.0,
            height: 1.4,
          ),
          bodyMedium: TextStyle(color: Colors.white60, fontSize: 14.0),
          labelLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: cardColor,
          indicatorColor: primaryColor,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              );
            }
            return const TextStyle(color: Colors.white60);
          }),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(color: secondaryColor);
            }
            return const IconThemeData(color: Colors.white60);
          }),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: isLogin ? const HomeDashboardPage() : const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

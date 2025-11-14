import 'package:flutter/material.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/presentation/dashboard/pages/main_page.dart';
import 'package:vitalytics/presentation/dashboard/pages/skin_care_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Health Analysis',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        // Define the color scheme
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
          surface: cardColor, // Used for cards, dialogs
          onSurface: Colors.white, // Text on cards
          tertiary: accentColor, // Accent color for buttons, highlights
          onTertiary: Colors.black,
        ),
        
        // Define text themes
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
          bodyMedium: TextStyle(
            color: Colors.white60,
            fontSize: 14.0,
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),

        // Define button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor, // Use the light accent
            foregroundColor: Colors.black, // Text color on the button
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

        // Define NavigationBar theme (Material 3)
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: cardColor, // Slightly lighter than pure black
          indicatorColor: primaryColor, // Indicator color when selected
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                color: secondaryColor, // Selected label color
                fontWeight: FontWeight.bold,
              );
            }
            return const TextStyle(
              color: Colors.white60, // Unselected label color
            );
          }),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(color: secondaryColor); 
            }
            return const IconThemeData(color: Colors.white60); 
          }),
        ),
        
        // App bar theme (for consistency if you add other app bars)
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
      home: const HomeDashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
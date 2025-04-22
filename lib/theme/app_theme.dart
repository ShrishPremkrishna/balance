import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryGreen = Color(0xFF2E7D32);
  static const primaryBlue = Color(0xFF1976D2);
  static const primaryRed = Color(0xFFD32F2F);
  static const darkBlue = Color(0xFF1A237E);
  static const backgroundColor = Color(0xFF1A1D1F);
  static const cardBackground = Color(0xFF1E1E1E);
  static const textLight = Colors.white;
  static const textGrey = Color(0xFF9E9E9E);
  static const modalBackground = Color(0xFF2C2C2C);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryGreen,
      surface: cardBackground,
      background: backgroundColor,
      onSurface: textLight,
      onBackground: textLight,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textLight,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: backgroundColor,
      indicatorColor: primaryGreen.withOpacity(0.2),
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(
          color: textLight,
          fontSize: 12,
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: textLight),
      displayMedium: TextStyle(color: textLight),
      displaySmall: TextStyle(color: textLight),
      headlineLarge: TextStyle(color: textLight),
      headlineMedium: TextStyle(color: textLight),
      headlineSmall: TextStyle(color: textLight),
      titleLarge: TextStyle(color: textLight),
      titleMedium: TextStyle(color: textLight),
      titleSmall: TextStyle(color: textLight),
      bodyLarge: TextStyle(color: textLight),
      bodyMedium: TextStyle(color: textLight),
      bodySmall: TextStyle(color: textLight),
    ),
    cardTheme: CardTheme(
      color: cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
} 
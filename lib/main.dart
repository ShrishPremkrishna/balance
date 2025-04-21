import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BalanceApp());
}

class BalanceApp extends StatelessWidget {
  const BalanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // Forest green as primary color
          brightness: Brightness.dark, // Dark theme by default
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1A1B1E), // Dark background
      ),
      home: const HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:juice_dash/pages/bottom_nav.dart';
import 'package:juice_dash/pages/home.dart';
import 'package:juice_dash/pages/juice.dart';
import 'package:juice_dash/pages/onboarding.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

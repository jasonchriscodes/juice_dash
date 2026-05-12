import 'package:flutter/material.dart';
import 'package:juice_dash/pages/bag.dart';
import 'package:juice_dash/pages/bottom_nav.dart';
import 'package:juice_dash/pages/order.dart';
import 'package:juice_dash/services/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "Home Page",
            style: AppWidget.headlineTextStyle(25),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: selectedIndex,
        onTap: (index) {
          if (index == 0) {
            // Already on Home page
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Order()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Bag()),
            );
          } else if (index == 3) {
            // Profile page later
          }
        },
      ),
    );
  }
}

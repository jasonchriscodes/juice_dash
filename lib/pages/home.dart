import 'package:flutter/material.dart';
import 'package:juice_dash/pages/bottom_nav.dart';
import 'package:juice_dash/pages/juice.dart';
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Find Our Best Juice",
                  style: AppWidget.headlineTextStyle(25.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(
                "images/banner.png",
                height: size.height * 0.16,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "images/water.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 80.0,
                        left: 20.0,
                        right: 20.0,
                        bottom: 20.0,
                      ),
                      child: Column(
                        children: [
                          _juiceItem(
                            context: context,
                            image: "images/orange-juice.png",
                            title: "Orange Juice",
                            kcal: "60 kcal",
                            description:
                                "Enjoy the freshness when starting\n your morning activities",
                          ),
                          const SizedBox(height: 30.0),
                          _juiceItem(
                            context: context,
                            image: "images/grape-juice.png",
                            title: "Grapes Juice",
                            kcal: "80 kcal",
                            description:
                                "Drink this fresh grapes juice makes\n you forgot the tiring activities",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            // Navigate to History page later
          } else if (index == 3) {
            // Navigate to Profile page later
          }
        },
      ),
    );
  }

  Widget _juiceItem({
    required BuildContext context,
    required String image,
    required String title,
    required String kcal,
    required String description,
  }) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 35.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2.0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(
            image,
            height: size.width * 0.22,
            width: size.width * 0.22,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppWidget.headlineTextStyle(17.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 28,
                      width: 65,
                      decoration: BoxDecoration(
                        color: const Color(0xffbcd986),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          kcal,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Juice(
                          juiceTitle: title,
                          juiceImage: image,
                          juiceKcal: kcal,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xfffebd7f),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2.0),
                    ),
                    child: Center(
                      child: Text(
                        "Add",
                        style: AppWidget.headlineTextStyle(17.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

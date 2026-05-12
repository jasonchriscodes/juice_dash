import 'package:flutter/material.dart';
import 'package:juice_dash/pages/bottom_nav.dart';
import 'package:juice_dash/pages/home.dart';
import 'package:juice_dash/services/support_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int selectedIndex = 1; // Order tab selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Order Page",
                style: AppWidget.headlineTextStyle(25),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "images/water.png",
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 3,
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                "images/orange-juice.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jason Christian",
                                  style: AppWidget.headlineTextStyle(18),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(41, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Image.asset(
                                        "images/tomato.png",
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(41, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Image.asset(
                                        "images/watermelon.png",
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(41, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Image.asset(
                                        "images/pineapple.png",
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Sugar: 6",
                                  style: AppWidget.headlineTextStyle(16),
                                ),
                                const Text(
                                  "Yet to be delivered",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
          setState(() {
            selectedIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } else if (index == 1) {
            // Already on Order page
          } else if (index == 2) {
            // Navigate to History page later
          } else if (index == 3) {
            // Navigate to Profile page later
          }
        },
      ),
    );
  }
}

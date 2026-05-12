import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juice_dash/pages/bottom_nav.dart';
import 'package:juice_dash/pages/home.dart';
import 'package:juice_dash/services/database.dart';
import 'package:juice_dash/services/shared_pref.dart';
import 'package:juice_dash/services/support_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? orderStream;
  int selectedIndex = 1; // Order tab selected
  String? id;

  getOnTheLoad() async {
    id = await SharedPreferenceHelper().getUserId();

    if (id != null && id!.isNotEmpty) {
      orderStream = await DatabaseMethods().getAllOrders(id!);
      setState(() {});
    } else {
      debugPrint("User ID is null. Please login again.");
    }
  }

  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  Widget allOrder() {
    if (orderStream == null) {
      return const Center(
        child: Text(
          "Please login again to view your orders",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
          ),
        ),
      );
    }
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];

                  return Container(
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
                                ds["JuiceName"] == "Orange Juice"
                                    ? "images/orange-juice.png"
                                    : ds["JuiceName"] == "Grapes Juice"
                                        ? "images/grape-juice.png"
                                        : "images/orange-juice.png",
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
                                  ds["Username"] ?? "Unknown User",
                                  style: AppWidget.headlineTextStyle(18),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    _fruitIcon(ds["Fruit1"]),
                                    const SizedBox(width: 5),
                                    _fruitIcon(ds["Fruit2"]),
                                    const SizedBox(width: 6),
                                    _fruitIcon(ds["Fruit3"]),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Sugar: ${ds["Sugar"] ?? "0"}",
                                  style: AppWidget.headlineTextStyle(16),
                                ),
                                Text(
                                  ds["Delivered"] == "true"
                                      ? "Delivered"
                                      : "Yet to be delivered",
                                  style: TextStyle(
                                    color: ds["Delivered"] == "true"
                                        ? Colors.green
                                        : Colors.red,
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
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget _fruitIcon(String? imagePath) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(41, 0, 0, 0),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Image.asset(
        imagePath ?? "images/tomato.png",
        height: 30,
        width: 30,
        fit: BoxFit.cover,
      ),
    );
  }

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
                      fit: BoxFit.cover,
                    ),
                  ),
                  allOrder(),
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

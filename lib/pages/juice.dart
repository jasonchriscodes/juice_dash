import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:juice_dash/services/database.dart';
import 'package:juice_dash/services/shared_pref.dart';
import 'package:juice_dash/services/support_widget.dart';

class Juice extends StatefulWidget {
  final String juiceTitle;
  final String juiceImage;
  final String juiceKcal;

  const Juice({
    super.key,
    required this.juiceTitle,
    required this.juiceImage,
    required this.juiceKcal,
  });

  @override
  State<Juice> createState() => _JuiceState();
}

class _JuiceState extends State<Juice> {
  TextEditingController notesController = new TextEditingController();
  String? id, username;

  int sugarCount = 1;

  final double totalPrice = 10.00;

  final List<String> fruits = [
    "images/tomato.png",
    "images/watermelon.png",
    "images/pineapple.png",
    "images/apple.png",
    "images/banana.png",
  ];

  String? selectedFruit1 = "images/tomato.png";
  String? selectedFruit2 = "images/watermelon.png";
  String? selectedFruit3 = "images/pineapple.png";

  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  Future<void> getOnTheLoad() async {
    id = await SharedPreferenceHelper().getUserId();
    username = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  int nzdToCents(double amount) {
    return (amount * 100).round();
  }

  Future<void> makePayment() async {
    try {
      final response = await http.post(
        Uri.parse(dotenv.get("STRIPE_SERVER_URL")),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "amount": nzdToCents(totalPrice),
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(jsonResponse["error"] ?? "Payment failed");
      }

      final String clientSecret = jsonResponse["clientSecret"];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Juice Dash",
        ),
      );

      Map<String, dynamic> addUserOrder = {
        "JuiceName": widget.juiceTitle,
        "JuiceImage": widget.juiceImage,
        "Kcal": widget.juiceKcal,
        "Sugar": sugarCount.toString(),
        "Fruit1": selectedFruit1,
        "Fruit2": selectedFruit2,
        "Fruit3": selectedFruit3,
        "Amount": totalPrice.toStringAsFixed(2),
        "Notes": notesController.text,
        "Username": username ?? "",
        "Delivered": "false",
        "CreatedAt": DateTime.now(),
      };

      if (id != null && id!.isNotEmpty) {
        await DatabaseMethods().addUserOrder(addUserOrder, id!);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Payment successful and order saved"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Payment failed: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xffebfbfe),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Image.asset(
                "images/mixer.png",
                height: 200,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    widget.juiceTitle,
                    style: AppWidget.headlineTextStyle(22),
                  ),
                  const SizedBox(width: 12.0),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffbcd986),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.juiceKcal,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Choose fruit to mix",
                style: AppWidget.headlineTextStyle(18),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFruitDropdown(selectedFruit1, (val) {
                  setState(() => selectedFruit1 = val);
                }),
                _buildFruitDropdown(selectedFruit2, (val) {
                  setState(() => selectedFruit2 = val);
                }),
                _buildFruitDropdown(selectedFruit3, (val) {
                  setState(() => selectedFruit3 = val);
                }),
              ],
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Add sugar",
                style: AppWidget.headlineTextStyle(18.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Sugar",
                        style: AppWidget.headlineTextStyle(18.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      if (sugarCount > 0) {
                        setState(() {
                          sugarCount--;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffecb47f),
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        sugarCount.toString(),
                        style: AppWidget.headlineTextStyle(18.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sugarCount++;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffecb47f),
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Add notes",
                style: AppWidget.headlineTextStyle(18.0),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: notesController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Container(
              height: 90,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Price : \$${totalPrice.toStringAsFixed(2)} NZD",
                    style: AppWidget.headlineTextStyle(18),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      makePayment();
                    },
                    child: Container(
                      width: 200,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xffecb47f),
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Mix and Pay",
                          style: AppWidget.headlineTextStyle(18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget _buildFruitDropdown(
    String? selectedFruit,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedFruit,
          hint: Image.asset(
            "images/tomato.png",
            width: 35,
            height: 35,
          ),
          items: fruits.map((fruitPath) {
            return DropdownMenuItem<String>(
              value: fruitPath,
              child: Image.asset(
                fruitPath,
                width: 35,
                height: 35,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

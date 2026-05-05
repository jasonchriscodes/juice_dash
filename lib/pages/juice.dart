import 'package:flutter/material.dart';
import 'package:juice_dash/services/support_widget.dart';

class Juice extends StatefulWidget {
  const Juice({super.key});

  @override
  State<Juice> createState() => _JuiceState();
}

class _JuiceState extends State<Juice> {
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                    bottomRight: Radius.circular(60))),
            child: Image.asset(
              "images/mixer.png",
              height: 200,
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
        ],
      ),
    ));
  }

  Widget _buildFruitDropdown(
      String? selectedFruit, Function(String?) onChanged) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: selectedFruit,
          hint: Image.asset("images/tomato.png", width: 35, height: 35),
          items: fruits.map((fruitPath) {
            return DropdownMenuItem<String>(
                value: fruitPath,
                child: Image.asset(fruitPath, width: 35, height: 35));
          }).toList(),
          onChanged: onChanged,
        )));
  }
}

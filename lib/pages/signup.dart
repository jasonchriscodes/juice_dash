import 'package:flutter/material.dart';
import 'package:juice_dash/services/support_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "images/bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text("Create\nAccount",
                  style: AppWidget.headlineTextStyle(40)),
            ),
            const SizedBox(
              height: 150,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              margin: const EdgeInsets.only(left: 40, right: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(60)),
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Full Name",
                    hintStyle: TextStyle(fontFamily: "Poppins")),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              margin: const EdgeInsets.only(left: 40, right: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(60)),
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    hintStyle: TextStyle(fontFamily: "Poppins")),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              margin: const EdgeInsets.only(left: 40, right: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(60)),
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(fontFamily: "Poppins")),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xffb900e7),
                      borderRadius: BorderRadius.circular(60)),
                  width: 200,
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}

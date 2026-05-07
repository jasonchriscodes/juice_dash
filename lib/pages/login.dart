import 'package:flutter/material.dart';
import 'package:juice_dash/pages/signup.dart';
import 'package:juice_dash/services/support_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              child:
                  Text("Welcome\nBack", style: AppWidget.headlineTextStyle(40)),
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: AppWidget.headlineTextStyle(16),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 80,
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
                  child: Center(
                    child: Text("Log In", style: AppWidget.whiteTextStyle(20)),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: AppWidget.headlineTextStyle(18),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signup()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Color(0xffb900e7),
                        fontSize: 18,
                        fontFamily: "Poppins"),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            )
          ],
        )
      ]),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juice_dash/pages/order.dart';
import 'package:juice_dash/pages/login.dart';
import 'package:juice_dash/services/database.dart';
import 'package:juice_dash/services/shared_pref.dart';
import 'package:juice_dash/services/support_widget.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  String? name, email, password;

  registration() async {
    setState(() {
      loading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      String id = randomAlpha(10);
      Map<String, dynamic> userInfoMap = {
        "Name": nameController.text,
        "Email": emailController.text,
        "Id": id,
        "Points": "0"
      };
      await SharedPreferenceHelper().saveUserId(id);
      await SharedPreferenceHelper().saveUserEmail(email!);
      await SharedPreferenceHelper().saveUserName(name!);
      await SharedPreferenceHelper().saveUserPoints("0");
      await DatabaseMethods().addUserInfo(userInfoMap, id);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Order()),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Registered Successfully!",
              style: AppWidget.whiteTextStyle(20))));
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Password provided is too weak",
              style: AppWidget.whiteTextStyle(20)),
        ));
        setState(() {
          loading = false;
        });
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Account already exists",
              style: AppWidget.whiteTextStyle(20)),
        ));
        setState(() {
          loading = false;
        });
      }
    }
  }

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
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Full Name",
                  hintStyle: TextStyle(fontFamily: "Poppins"),
                ),
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
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  hintStyle: TextStyle(fontFamily: "Poppins"),
                ),
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
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(fontFamily: "Poppins"),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    name = nameController.text;
                    email = emailController.text;
                    password = passwordController.text;
                    registration();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please fill all fields",
                          style: AppWidget.whiteTextStyle(20),
                        ),
                      ),
                    );
                  }
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffb900e7),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    width: 200,
                    child: Center(
                      child: loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Sign Up",
                              style: AppWidget.whiteTextStyle(20),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: AppWidget.headlineTextStyle(18),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Color(0xffb900e7),
                      fontSize: 18,
                      fontFamily: "Poppins",
                    ),
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

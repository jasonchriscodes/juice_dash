import 'package:flutter/material.dart';
import 'package:juice_dash/services/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(left: 0.0),
          child: Column(
            children: [
              SizedBox(height: 70.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Find Our Best Juice",
                    style: AppWidget.headlineTextStyle(25.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Image.asset("images/banner.png"),
              ),
              Stack(
                children: [
                  Image.asset(
                    "images/water.png",
                    height: MediaQuery.of(context).size.height / 1.43,
                  ),
                ],
              )
            ],
          )),
    );
  }
}

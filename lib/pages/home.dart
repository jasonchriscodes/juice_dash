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
          margin: const EdgeInsets.only(left: 0.0),
          child: Column(
            children: [
              const SizedBox(height: 70.0),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 150.0, left: 20.0),
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 40.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 2.0),
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset("images/orange-juice.png",
                                height: 90, width: 90, fit: BoxFit.cover)),
                        const SizedBox(width: 20.0),
                        Container(
                            margin: const EdgeInsets.only(right: 20.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 2.0),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Orange Juice",
                                          style: AppWidget.headlineTextStyle(
                                              18.0)),
                                      SizedBox(width: 20.0),
                                      Container(
                                        height: 30,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffbcd986),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                            child: Text("60 kcal",
                                                style: TextStyle(
                                                    fontFamily: "Poppins"))),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  const Text(
                                    "Enjoy the freshness when starting\n your morning activities",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Center(
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        decoration: BoxDecoration(
                                            color: const Color(0xfffebd7f),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(width: 2.0)),
                                        child: Center(
                                            child: Text("Add",
                                                style:
                                                    AppWidget.headlineTextStyle(
                                                        18.0)))),
                                  ),
                                ]))
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

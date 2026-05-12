import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juice_dash/services/database.dart';
import 'package:juice_dash/services/support_widget.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({super.key});

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
  String? updatingOrderId;

  Widget allAdminOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseMethods().getAllUsersOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error loading orders: ${snapshot.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No orders yet",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];

            final data = ds.data() as Map<String, dynamic>;

            final String delivered = data["Delivered"] ?? "false";
            final bool isDelivered = delivered == "true";
            final bool isUpdating = updatingOrderId == ds.id;

            return Container(
              margin: const EdgeInsets.all(20),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 3,
                child: Container(
                  height: 150,
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
                          data["JuiceImage"] ?? "images/orange-juice.png",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["Username"] ?? "Unknown User",
                              style: AppWidget.headlineTextStyle(18),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                _fruitIcon(data["Fruit1"]),
                                const SizedBox(width: 5),
                                _fruitIcon(data["Fruit2"]),
                                const SizedBox(width: 6),
                                _fruitIcon(data["Fruit3"]),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Sugar: ${data["Sugar"] ?? "0"}",
                              style: AppWidget.headlineTextStyle(16),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: isDelivered || isUpdating
                                  ? null
                                  : () async {
                                      setState(() {
                                        updatingOrderId = ds.id;
                                      });

                                      await DatabaseMethods()
                                          .markUserOrderDelivered(ds.reference);

                                      setState(() {
                                        updatingOrderId = null;
                                      });
                                    },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: isDelivered ? Colors.grey : Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  isUpdating
                                      ? "Updating..."
                                      : isDelivered
                                          ? "Delivered"
                                          : "Delivery",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
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
              ),
            );
          },
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
                "Manage Orders",
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
                  allAdminOrders(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

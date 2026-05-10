import 'package:flutter/material.dart';
import 'package:juice_dash/services/shared_pref.dart';
import 'package:juice_dash/services/support_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Juice extends StatefulWidget {
  const Juice({super.key});

  @override
  State<Juice> createState() => _JuiceState();
}

class _JuiceState extends State<Juice> {
  String? id;
  late Razorpay _razorpay;

  final String razorKey = "YOUR_RAZORPAY_KEY_HERE";

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

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> getOnTheLoad() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Successful: ${response.paymentId}"),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Failed: ${response.message}"),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External Wallet: ${response.walletName}"),
      ),
    );
  }

  void openCheckout(String amount) {
    var options = {
      "key": razorKey,
      "amount": int.parse(amount) * 100,
      "name": "Juice Dash",
      "description": "Payment for your order",
      "prefill": {
        "contact": "8888888888",
        "email": "H2h0d@example.com",
      },
      "external": {
        "wallets": ["paytm"],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

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
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffecb47f),
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(Icons.remove),
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
                        "1",
                        style: AppWidget.headlineTextStyle(18.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffecb47f),
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(Icons.add),
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
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width,
              child: const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
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
                    "Total Price : \$50",
                    style: AppWidget.headlineTextStyle(18),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      openCheckout("50");
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

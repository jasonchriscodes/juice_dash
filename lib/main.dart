import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:juice_dash/pages/order.dart';
import 'package:juice_dash/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final firebaseApiKey = dotenv.get("FIREBASE_API_KEY");
  final firebaseAppId = dotenv.get("FIREBASE_APP_ID");
  final firebaseSenderId = dotenv.get("FIREBASE_MESSAGING_SENDER_ID");
  final firebaseProjectId = dotenv.get("FIREBASE_PROJECT_ID");
  final firebaseStorageBucket = dotenv.get("FIREBASE_STORAGE_BUCKET");
  final stripePublishableKey = dotenv.get("STRIPE_PUBLISHABLE_KEY");
  final stripeServerUrl = dotenv.get("STRIPE_SERVER_URL");

  debugPrint(
      "STRIPE_PUBLISHABLE_KEY ends with: ${stripePublishableKey.substring(stripePublishableKey.length - 5)}");
  debugPrint("STRIPE_PUBLISHABLE_KEY length: ${stripePublishableKey.length}");
  debugPrint("STRIPE_SERVER_URL: $stripeServerUrl");

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: firebaseApiKey,
      appId: firebaseAppId,
      messagingSenderId: firebaseSenderId,
      projectId: firebaseProjectId,
      storageBucket: firebaseStorageBucket,
    ),
  );

  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

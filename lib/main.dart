import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:juice_dash/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.get("FIREBASE_API_KEY"),
      appId: dotenv.get("FIREBASE_APP_ID"),
      messagingSenderId: dotenv.get("FIREBASE_MESSAGING_SENDER_ID"),
      projectId: dotenv.get("FIREBASE_PROJECT_ID"),
      storageBucket: dotenv.get("FIREBASE_STORAGE_BUCKET"),
    ),
  );

  Stripe.publishableKey = dotenv.get("STRIPE_PUBLISHABLE_KEY");
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

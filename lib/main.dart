import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:juice_dash/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD8OCTXbReVLhYSqIbB0JPyDpWDbYT6CNA",
      appId: "1:213483775299:android:8e485d0f1618d49ca33bf6",
      messagingSenderId: "213483775299",
      projectId: "juicedash-b5ec3",
      storageBucket: "juicedash-b5ec3.firebasestorage.app",
    ),
  );

  Stripe.publishableKey =
      "pk_test_51TVYWaQkiOa9VUMNazbLLBz7QaOfSBqez94CH6sJckvjwGyEtQq81QwFKClwDhvvqknRwES2wIQKOWmH76txL3KD001zWaCWxq";
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

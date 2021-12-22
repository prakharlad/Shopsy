// ignore_for_file: avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopsy/screens/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: prefer_const_constructors
  Stripe.publishableKey =
      'pk_test_51HUntNLvqIp7L0hHR30mQlHJJK4WrmXzTOzZF3Py686bTZ1UyEEkD486vfx1yaP1cU7DXYVn73coF0Ap8eMAftq9006M1iQYRp';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Stripe.publishableKey = 'pk_test_51JhtqUSHZoAK8PJWd9e3LrE8qgXy4SVLAKDrdXpsnE2xtcgUHonndVuvB5IJO8bm8dF4CCuKrwRFGc8Ccp1AVAhz00HZ3K2qcq';
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: Colors.deepOrange.shade900,
      ),
      home: const LandingPage(),
    );
  }
}

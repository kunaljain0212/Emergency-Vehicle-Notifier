import 'package:emergency_notifier/screens/landing_page.dart';
import 'package:emergency_notifier/utils/custom_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      routes: {
        CustomRoutes.landingPage: (context) => LandingPage(),
      },
    );
  }
}

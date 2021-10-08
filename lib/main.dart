import 'package:emergency_notifier/providers/auth_provider.dart';
import 'package:emergency_notifier/screens/home_page.dart';
import 'package:emergency_notifier/screens/signup_page.dart';
import 'package:emergency_notifier/utils/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:emergency_notifier/screens/landing_page.dart';
import 'package:emergency_notifier/utils/custom_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
        routes: {
          CustomRoutes.landingPage: (context) => const LandingPage(),
          CustomRoutes.auth: (context) => const AuthWrapper(),
          CustomRoutes.signupPage: (context) => const SignUpPage(),
          CustomRoutes.home: (context) => const HomePage(),
        },
      ),
    );
  }
}

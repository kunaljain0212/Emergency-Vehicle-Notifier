import 'package:emergency_notifier/widgets/custom_button_light.dart';
import 'package:emergency_notifier/widgets/custom_button_white.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(0.5),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'e-Sevak',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'e-Sevak, your Sevak in the situations of emergency.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 70,
            ),
            CustomButtonWhite(
              text: 'Continue as user',
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButtonLight(
              text: 'Continue as driver',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
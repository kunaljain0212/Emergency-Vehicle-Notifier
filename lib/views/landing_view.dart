import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/common/routes.dart';
import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  final Function toggleLanding;

  const LandingView(this.toggleLanding, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Image.asset('assets/images/landing.jpg'),
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    'Tired of all the recoil?',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      'Join our community to get all the latest gaming news and updates.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => toggleLanding(),
                        child: const Text(
                          'Get Started',
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

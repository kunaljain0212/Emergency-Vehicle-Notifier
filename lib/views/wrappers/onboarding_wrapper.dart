import 'package:flutter/material.dart';
import 'package:emergency_notifier/views/landing_view.dart';
import 'package:emergency_notifier/views/signup_login_view.dart';

class OnboardingWrapper extends StatefulWidget {
  const OnboardingWrapper({Key? key}) : super(key: key);

  @override
  _OnboardingWrapperState createState() => _OnboardingWrapperState();
}

class _OnboardingWrapperState extends State<OnboardingWrapper> {
  bool _isLanding = true;

  void _toggleLanding() {
    setState(() {
      _isLanding = !_isLanding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLanding ? LandingView(_toggleLanding) : const SignUpLoginView();
  }
}

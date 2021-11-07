import 'package:flutter/widgets.dart';
import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/views/wrappers/home_wrapper.dart';
import 'package:emergency_notifier/views/wrappers/onboarding_wrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel?>(context);
    if (auth == null) {
      return const OnboardingWrapper();
    } else {
      return const HomeView();
    }
  }
}

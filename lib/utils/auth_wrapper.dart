import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:emergency_notifier/models/user_model.dart';
import 'package:emergency_notifier/providers/auth_provider.dart';
import 'package:emergency_notifier/screens/signup_page.dart';
import 'package:emergency_notifier/screens/home_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return StreamBuilder<UserModel?>(
      stream: authProvider.user,
      builder: (_, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserModel? user = snapshot.data;
          return user == null ? const SignUpPage() : const HomePage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

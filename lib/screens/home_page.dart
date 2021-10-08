import 'package:emergency_notifier/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authProvider.logout();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}

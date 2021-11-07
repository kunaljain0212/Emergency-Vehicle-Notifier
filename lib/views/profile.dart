import 'package:flutter/material.dart';
import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/services/auth_service.dart';
import 'package:emergency_notifier/widgets/loading.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthService _auth = AuthService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Loading()
        : Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = !_isLoading;
                                });
                                _auth.signOut();
                              },
                              child: const Text(
                                'Logout',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

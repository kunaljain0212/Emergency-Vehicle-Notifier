import 'package:flutter/material.dart';

import 'package:emergency_notifier/widgets/buttons/custom_button_google.dart';
import 'package:emergency_notifier/widgets/buttons/custom_button_light.dart';
import 'package:emergency_notifier/widgets/inputs/custom_email_input.dart';
import 'package:emergency_notifier/widgets/inputs/custom_password_input.dart';
import 'package:emergency_notifier/widgets/inputs/custom_text_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final hospitalNameController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    vehicleNumberController.addListener(() {
      setState(() {});
    });
    hospitalNameController.addListener(() {
      setState(() {});
    });
  }

  void showHidePassword() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 80,
            ),
            CustomTextInput(
              nameController,
              'Enter you name',
              'Name',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomEmailInput(emailController),
            const SizedBox(
              height: 20,
            ),
            CustomPasswordInput(
              passwordController,
              showHidePassword,
              isPasswordVisible,
            ),
            const SizedBox(
              height: 20,
            ),
            role == 'driver'
                ? CustomTextInput(
                    vehicleNumberController,
                    'Enter you vehicle number',
                    'Vehicle Number',
                  )
                : Container(),
            role == 'driver'
                ? const SizedBox(
                    height: 20,
                  )
                : Container(),
            role == 'driver'
                ? CustomTextInput(
                    hospitalNameController,
                    'Enter you hospital name',
                    'Hospital Name',
                  )
                : Container(),
            const SizedBox(
              height: 20,
            ),
            CustomButtonLight(
              text: 'Sign up',
              onPressed: () {
                // print(nameController.text);
                // print(emailController.text);
                // print(passwordController.text);
                // print(vehicleNumberController.text);
                // print(hospitalNameController.text);

                nameController.clear();
                emailController.clear();
                passwordController.clear();
                vehicleNumberController.clear();
                hospitalNameController.clear();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const GoogleButton(),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: Colors.grey,
              indent: 60,
              endIndent: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already signed up?'),
                TextButton(
                  onPressed: () {},
                  child: const Text('Sign in'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

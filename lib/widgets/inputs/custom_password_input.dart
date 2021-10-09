import 'package:flutter/material.dart';

class CustomPasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final Function showHidePassword;
  final bool isPasswordVisible;

  const CustomPasswordInput(
      this.controller, this.showHidePassword, this.isPasswordVisible,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        labelText: 'Password',
        suffixIcon: controller.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                onPressed: () => showHidePassword(),
                icon: isPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
        border: const OutlineInputBorder(),
      ),
      obscureText: isPasswordVisible,
      textInputAction: TextInputAction.next,
    );
  }
}

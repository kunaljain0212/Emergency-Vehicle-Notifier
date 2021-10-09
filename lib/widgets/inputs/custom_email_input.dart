import 'package:flutter/material.dart';

class CustomEmailInput extends StatelessWidget {
  final TextEditingController controller;

  const CustomEmailInput(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Enter your email',
        labelText: 'Email',
        suffixIcon: controller.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                onPressed: () => controller.clear(),
                icon: const Icon(Icons.clear),
              ),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }
}

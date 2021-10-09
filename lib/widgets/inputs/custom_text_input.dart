import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  const CustomTextInput(this.controller, this.hintText, this.labelText,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
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
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}

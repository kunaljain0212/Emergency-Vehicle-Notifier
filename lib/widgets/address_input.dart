import 'package:flutter/material.dart';

class AddressInput extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final Function onTap;
  final bool isEnabled;

  const AddressInput({
    Key? key,
    required this.icon,
    required this.controller,
    required this.hint,
    required this.onTap,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            size: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 8, 0, 8),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              enabled: isEnabled,
              onTap: () => onTap(),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              ),
            ),
          ),
        )
      ],
    );
  }
}

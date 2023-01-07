import 'package:flutter/material.dart';

class PasswordText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autoCorrect;
  final bool suggestion;
  final bool obscureText;
  PasswordText({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.autoCorrect,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    final password = controller.text;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        autocorrect: autoCorrect,
        enableSuggestions: suggestion,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value != null && value.length < 6 ? 'Input atleast 6 characters' : null,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PasswordText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autoCorrect;
  final bool suggestion;
  final bool obscureText;

  const PasswordText({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.autoCorrect,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        autocorrect: autoCorrect,
        enableSuggestions: suggestion,
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

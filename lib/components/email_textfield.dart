import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autoCorrect;
  final bool suggestion;
  const EmailText(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.autoCorrect,
      required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        autocorrect: autoCorrect,
        enableSuggestions: suggestion,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) => email!= null && !EmailValidator.validate(email) ? 'Enter a valid email': null,
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
          suffixIcon: TextButton(
            child: const Text("Send OTP"),
            onPressed: (){},
          )
        ),
      ),
    );
  }
}

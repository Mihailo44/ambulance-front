import 'package:flutter/material.dart';

Widget buildTextFormField(
    {required TextEditingController controller, required String labelText}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        fontSize: 20,
      )
    ),
    style: const TextStyle(
      fontSize: 22,
    ),
    validator: (value) => _validateField(controller.text.trim(), labelText),
  );
}

String? _validateField(String? value, String labelText) {
  if (value == null || value.isEmpty) { 
    return "$labelText is required";
  }

  return null;
}

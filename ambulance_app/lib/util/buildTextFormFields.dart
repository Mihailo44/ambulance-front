import 'package:flutter/material.dart';

Widget buildTextFormField(
    {required TextEditingController controller,
    required String labelText,
    bool enabled = true}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 20,
          )),
      style: const TextStyle(
        fontSize: 22,
      ),
      validator: (value) => _validateField(controller.text.trim(), labelText),
    ),
  );
}

Widget buildCenteredTextFormField(
    {required TextEditingController controller,
    required String labelText,
    bool enabled = true}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: TextFormField(
      controller: controller,
      enabled: enabled,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        label: Align(
          alignment: Alignment.center,
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 22,
      ),
      validator: (value) => _validateField(controller.text.trim(), labelText),
    ),
  );
}

String? _validateField(String? value, String labelText) {
  if (value == null || value.isEmpty) {
    return "$labelText is required";
  }

  return null;
}

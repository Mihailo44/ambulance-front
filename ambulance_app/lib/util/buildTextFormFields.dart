import 'package:flutter/material.dart';

Widget buildTextFormField({
    required TextEditingController controller,
    required String labelText
  }){
    return 
    TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: (value) => _validateField(value,labelText),
    );
  }

  String? _validateField(String? value,String labelText){
    if(value == null || value.isEmpty){
      return "$labelText is required";
    }

    return null;
  }
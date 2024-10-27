import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  WidgetsBinding.instance.addPostFrameCallback((_){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 66, 103, 210),
        showCloseIcon: true,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
          ),
        duration: const  Duration(seconds: 2),
      ),
    );
  });
}
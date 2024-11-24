import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.error,super.key});
  final String error;

  @override
  Widget build(BuildContext context) {
    return  const Center(
        child: SelectableText("Something went wrong"),
      );
  }
}

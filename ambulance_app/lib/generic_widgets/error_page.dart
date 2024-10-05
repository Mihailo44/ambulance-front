import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String error;
  const ErrorPage(this.error);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: Center(
        child: SelectableText("Error: $error"),
      ),
    );
  }
}

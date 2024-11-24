import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
<<<<<<< HEAD
  const ErrorPage({required this.error,super.key});
  final String error;

  @override
  Widget build(BuildContext context) {
    return  const Center(
        child: SelectableText("Something went wrong"),
      );
=======
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
>>>>>>> main
  }
}

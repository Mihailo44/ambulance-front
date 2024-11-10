import 'package:flutter/material.dart';

Widget buildFormattedTextField(
    BuildContext context, String label, String text) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}

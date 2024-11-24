import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget buildFormattedTextField(
<<<<<<< HEAD
    BuildContext context, String? label, String? text ) {
=======
    BuildContext context, String label, String text ) {
>>>>>>> main
  return Padding(
    padding: const EdgeInsets.fromLTRB(10,10,10,15),
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
<<<<<<< HEAD
            label ?? "",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 5,),
          text == null || text.isEmpty ? const SizedBox.shrink() : AutoSizeText(
=======
            label,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 5,),
          text.isEmpty ? const SizedBox.shrink() : AutoSizeText(
>>>>>>> main
            text,
            maxLines: 9,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    ),
  );
}

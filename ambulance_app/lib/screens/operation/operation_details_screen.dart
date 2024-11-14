import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter/material.dart';

class OperationDetailsScreen extends StatelessWidget {
  const OperationDetailsScreen({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            buildFormattedTextField(context, "Operation type", name),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text("Edit"),
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text("Delete"),
                    icon: const Icon(Icons.delete),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

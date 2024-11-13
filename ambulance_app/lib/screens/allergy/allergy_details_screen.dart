import 'package:ambulance_app/model/allergy.dart';
import 'package:flutter/material.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';

class AllergyDetailsScreen extends StatelessWidget {
  const AllergyDetailsScreen({required this.allergy, super.key});

  final Allergy allergy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          buildFormattedTextField(context, "Allergen", allergy.allergen),
          buildFormattedTextField(context, "Description", allergy.description),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              "Medications",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          allergy.medications == null || allergy.medications!.isEmpty
              ? const Text('No medications available')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: allergy.medications!.map((e) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Text(
                        "${e.name} x ${e.weeklyDosage} times",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  }).toList(),
                ),
          const Spacer(),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Edit"),
              icon: const Icon(Icons.edit),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: ElevatedButton.icon(
                onPressed: () {},
                label: const Text("Delete"),
                icon: const Icon(Icons.delete),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/model/allergy.dart';
import 'package:flutter/material.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';

class AllergyDetailsScreen extends StatelessWidget {
  const AllergyDetailsScreen({required this.allergy, super.key});

  final Allergy allergy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(
            height: 75,
          ),
          buildFormattedTextField(context, "Allergen", allergy.allergen),
          buildFormattedTextField(context, "Description", allergy.description),
          buildFormattedTextField(context, "Medications", ""),
          allergy.medications == null || allergy.medications!.isEmpty
              ? const Text('No medications available')
              : Column(
                  children: allergy.medications!.map((e) {
                    return Text("${e.name} ${e.weeklyDosage} times");
                  }).toList(),
                ),
          const SizedBox(
            height: 140,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            label: const Text("Edit"),
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            label: const Text("Delete"),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

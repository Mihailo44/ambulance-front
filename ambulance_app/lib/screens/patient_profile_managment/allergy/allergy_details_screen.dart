import 'package:ambulance_app/generic_widgets/my_dialog.dart';
import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/screens/patient_profile_managment/allergy/edit_allergy_screen.dart';
import 'package:flutter/material.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllergyDetailsScreen extends ConsumerWidget {
  const AllergyDetailsScreen({required this.allergy, super.key});

  final Allergy allergy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => EditAllergyScreen(
                      allergy: allergy,
                    ),
                  ),
                );
              },
              label: const Text("Edit"),
              icon: const Icon(Icons.edit),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: ElevatedButton.icon(
                onPressed: () async {
                  var nav = Navigator.of(context);
                  bool? result = await showDialog<bool>(
                      context: context, builder: (ctx) => const MyDialog());
                  if (result != null && result == true) {
                    ref.read(patientProvider.notifier).removeAllergy(allergy);
                    nav.pop();
                  }
                },
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

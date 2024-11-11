import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/screens/details/allergy_details_screen.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicalInfoScreen extends ConsumerWidget {
  const MedicalInfoScreen({required this.patient, super.key});

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 253, 253, 247),
        scrolledUnderElevation: 0,
        leading: IconButton(
            iconSize: 32,
            color: Colors.amber,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
                Navigator.of(context).pop();
              }
            }),
        title: Text(
          "Medical Information",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: 
            Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      buildFormattedTextField(
                      context, "Blood Type", patient.bloodType),
                      buildFormattedTextField(context, "Gender", patient.gender)
                    ],
                  ),
                  buildFormattedTextField(context, "Past Operations", ""),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: patient.pastOperations?.split(',').length,
                      itemBuilder: (ctx, idx) {
                        final operation =
                            patient.pastOperations?.split(',')[idx].trim();
                        return CustomListTile(
                            title: operation!, onPressed: () {
                            });
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  buildFormattedTextField(context, "Allergies", ""),
                  patient.alergies.isEmpty
                      ? const Text("No alergies")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: patient.alergies.length,
                          itemBuilder: (ctx, idx) {
                            return CustomListTile(
                              title: patient.alergies[idx].allergen,
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context, 
                                  builder: (ctx) => AllergyDetailsScreen(allergy: patient.alergies[idx]));
                              },
                              mode: Mode.display,
                            );
                          }),
                  const SizedBox(height: 12,),
                  buildFormattedTextField(context, "Diseases", ""),
                  patient.diseases.isEmpty
                      ? const Text("No diseases")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: patient.diseases.length,
                          itemBuilder: (ctx, idx) {
                            return CustomListTile(
                              title: patient.diseases[idx].name,
                              onPressed: () {},
                              mode: Mode.display,
                            );
                          }),
                ],
              ),
            ),
          ),
        ),
      );
  }
}

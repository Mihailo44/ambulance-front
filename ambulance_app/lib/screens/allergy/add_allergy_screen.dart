import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/medication.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:flutter/material.dart';

class AddAllergyScreen extends StatefulWidget {
  const AddAllergyScreen({super.key});

  @override
  State<AddAllergyScreen> createState() => _AddAllergyScreenState();
}

class _AddAllergyScreenState extends State<AddAllergyScreen> {
  final List<Medication> _medications = [];
  final _allergenController = TextEditingController();
  final _additionalInformationController = TextEditingController();
  final _medicationNameController = TextEditingController();
  final _medicationUsageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _allergenController.dispose();
    _additionalInformationController.dispose();
    _medicationNameController.dispose();
    _medicationUsageController.dispose();
  }

  void _showAddMedication() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                12.0, 12, 12, MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                buildTextFormField(
                    controller: _medicationNameController, labelText: "Name"),
                buildTextFormField(
                    controller: _medicationUsageController,
                    labelText: "Weekly Dose"),
                ElevatedButton.icon(
                  onPressed: _addMedication,
                  label: const Text("Add"),
                ),
              ],
            ),
          );
        });
  }

  void _addMedication() {
    if (_medicationNameController.text.isEmpty) return;

    Medication med = Medication(
        name: _medicationNameController.text,
        weeklyDosage: int.parse(_medicationUsageController.text));

    setState(() {
      _medications.add(med);
    });

    _medicationNameController.clear();
    _medicationUsageController.clear();
    Navigator.of(context).pop();
  }

  void _removeMedication(String name) {
    setState(() {
      _medications.removeWhere((e) => e.name == name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Add Allergy",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            buildTextFormField(
                controller: _allergenController, labelText: "Alergen"),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                buildFormattedTextField(context, "Medications", ""),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: IconButton(
                    onPressed: _showAddMedication,
                    icon: const Icon(Icons.add),
                    iconSize: 34,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            _medications.isEmpty
                ? Text(
                    "No medications",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _medications.length,
                    itemBuilder: (ctx, idx) {
                      return Dismissible(
                        key: ValueKey(_medications[idx].name),
                        onDismissed: (direction) {},
                        child: CustomListTile(
                          title: _medications[idx].name,
                          onPressed: () {
                            _removeMedication(_medications[idx].name);
                          },
                          mode: Mode.delete,
                        ),
                      );
                    }),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _additionalInformationController,
              decoration: const InputDecoration(
                labelText: 'Note (Optional)',
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              minLines: 2,
              keyboardType: TextInputType.multiline,
            ),
            //const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text("Save"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

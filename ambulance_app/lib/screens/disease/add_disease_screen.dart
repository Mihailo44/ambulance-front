import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/medication.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDiseaseScreen extends ConsumerStatefulWidget {
  const AddDiseaseScreen({super.key});

  @override
  ConsumerState<AddDiseaseScreen> createState() => _AddDiseaseScreenState();
}

class _AddDiseaseScreenState extends ConsumerState<AddDiseaseScreen>{

  final List<Medication> _medications = [];
  final _nameController = TextEditingController();
  final _medicationNameController = TextEditingController();
  final _medicationUsageController = TextEditingController();

  void _showAddMedication() {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          //MediaQuery.of(context).viewInsets.bottom
          return SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: buildTextFormField(
                              controller: _medicationNameController,
                              labelText: "Name"),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: buildTextFormField(
                              controller: _medicationUsageController,
                              labelText: "Weekly Dose"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _medicationNameController.clear();
                          _medicationUsageController.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.of(context).pop();
                        },
                        label: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton.icon(
                        onPressed: _addMedication,
                        label: const Text("Add"),
                      ),
                    ],
                  ),
                ],
              ),
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
    FocusScope.of(context).requestFocus(FocusNode());
    close(context);
  }

  void _removeMedication(String name) {
    setState(() {
      _medications.removeWhere((e) => e.name == name);
    });
  }

  void _saveDisease(){
    Disease disease = Disease(name: _nameController.text, medications: _medications);
    ref.read(patientProvider.notifier).addDisease(disease);
    close(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _medicationNameController.dispose();
    _medicationUsageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 255, 249, 234),
          scrolledUnderElevation: 0,
          leading: IconButton(
              iconSize: 32,
              color: Colors.amber,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              }),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              12, 12, 12, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Add Disease",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              buildTextFormField(
                  controller: _nameController, labelText: "Name"),
              const SizedBox(
                height: 10,
              ),
              buildFormattedTextField(context, "Medications", ""),
              _medications.isEmpty
                  ? SizedBox(
                      height: 120,
                      child: Center(
                        child: Text(
                          "No medications",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : SizedBox(
                    height: 250,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _medications.length,
                        itemBuilder: (ctx, idx) {
                          return Dismissible(
                            key: ValueKey(_medications[idx].name),
                            onDismissed: (direction) {
                              _removeMedication(_medications[idx].name);
                            },
                            child: CustomListTile(
                              title: _medications[idx].name,
                              onPressed: () {
                                _removeMedication(_medications[idx].name);
                              },
                              mode: Mode.delete,
                            ),
                          );
                        }),
                  ),
              Transform.translate(
                offset: _medications.isNotEmpty && _medications.length <= 3 ? Offset(0, -190 + _medications.length * 65) : const Offset(0, 5),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: _showAddMedication,
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                  ),
                ),
              ),
              SizedBox(
                height: _medications.isEmpty ? 210 : 80,
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveDisease,
                  label: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  
}
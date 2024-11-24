import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/medication.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAllergyScreen extends ConsumerStatefulWidget {
  const EditAllergyScreen({required this.allergy,super.key});

  final Allergy allergy;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditAllergyScreenState();
}

class _EditAllergyScreenState extends ConsumerState<EditAllergyScreen>{

  final List<Medication> _medications = [];
  final _allergenController = TextEditingController();
  final _additionalInformationController = TextEditingController();
  final _medicationNameController = TextEditingController();
  final _medicationUsageController = TextEditingController();
  double  _medicationsBoxHeight = 0;

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
    Navigator.of(context).pop();

    setState(() {
      _medicationsBoxHeight += 78;
    });
  }

  void _removeMedication(String name) {
    setState(() {
      _medications.removeWhere((e) => e.name == name);
      _medicationsBoxHeight-=78;
    });
  }

  void _saveAllergy(){
    ref.read(patientProvider.notifier).removeAllergy(widget.allergy);
    Allergy allergy = Allergy(allergen: _allergenController.text, description: _additionalInformationController.text,medications: _medications);
    ref.read(patientProvider.notifier).addAllergy(allergy);
    close(context);
    close(context);
  }

  @override
  void dispose() {
    super.dispose();
    _allergenController.dispose();
    _additionalInformationController.dispose();
    _medicationNameController.dispose();
    _medicationUsageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _allergenController.text = widget.allergy.allergen;
    if(widget.allergy.medications != null){
      _medications.addAll(widget.allergy.medications as List<Medication>);
      _medicationsBoxHeight = _medications.length * 70;
    }
    _additionalInformationController.text = widget.allergy.description;
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
                "Edit Allergy",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              buildTextFormField(
                  controller: _allergenController, labelText: "Alergen"),
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
                    height: _medicationsBoxHeight,
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
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _showAddMedication,
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ),
              
              const SizedBox(height: 30,),
              buildFormattedTextField(context, "Note (Optional)", ""),
              TextFormField(
                controller: _additionalInformationController,
                decoration: const InputDecoration(
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
                style: const TextStyle(
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: _saveAllergy,
                    label: const Text("Save"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  
}
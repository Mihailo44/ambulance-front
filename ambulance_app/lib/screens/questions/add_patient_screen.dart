import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({required this.onAddPatient, super.key});

  final void Function(String patient) onAddPatient;

  @override
  State<AddPatientScreen> createState() => _StateAddPatientScreen();
}

class _StateAddPatientScreen extends State<AddPatientScreen> {
  final _patientUsernameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _yearOfBirth = TextEditingController();
  final List<String> _genders = ["Male", "Female"];
  String? _selectedGender = "";

  final _kurac = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _patientUsernameController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _yearOfBirth.dispose();
  }

  void _add() {
    if (_patientUsernameController.text.isNotEmpty) {
      widget.onAddPatient(_patientUsernameController.text);
      Navigator.pop(context);
    } else {
      showSnackBar(context, "Please enter patients ID first");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: Text(
                "Please add a patient",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: buildTextFormField(
                        controller: _patientUsernameController,
                        labelText: "Enter Patient ID"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                    label: const Text("Add patient"),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _add();
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.amber,
              height: 10,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: Text(
                "If you can't find patients ID, write all information you know below please",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: Container(
                width: 300,
                
                child: Form(
                  key: _kurac,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          buildTextFormField(
                              controller: _firstnameController,
                              labelText: "Firstname"),
                          const SizedBox(
                            width: 15,
                          ),
                          buildTextFormField(
                              controller: _lastnameController,
                              labelText: "Lastname"),
                        ],
                      ),
                      buildTextFormField(
                          controller: _yearOfBirth, labelText: "Year Of Birth"),
                      DropdownButtonFormField<String>(
                                hint: const Text("Gender",
                                style: TextStyle(
                                      fontSize: 20,
                                    ),),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                                items: [
                                  for (final g in _genders)
                                    DropdownMenuItem(
                                        value: g,
                                        child: Text(
                                          g,
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ))
                                ],
                              ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

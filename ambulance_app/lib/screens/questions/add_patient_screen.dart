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
  final _yearOfBirthController = TextEditingController();
  final List<String> _genders = ["Male", "Female"];
  String? _selectedGender = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _patientUsernameController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _yearOfBirthController.dispose();
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
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 12, 25, 5),
              child: Text(
                "Add a patient with his ID",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 20),
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
              height: 8,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 12, 25, 5),
              child: Text(
                "Or write all information you know below please",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            //! ISPOD JE SJEBANO
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: buildTextFormField(
                            controller: _firstnameController,
                            labelText: "Firstname"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: buildTextFormField(
                            controller: _lastnameController,
                            labelText: "Lastname"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextFormField(
                            controller: _yearOfBirthController,
                            labelText: "Age/Birthdate"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          hint: const Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
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
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Patient description', //* neke bitne stvari stavi hintove, krvna grupa, invaliditet itd
                      border: OutlineInputBorder(),
                      alignLabelWithHint:
                          true, // Aligns the label to the top for multiline
                    ),
                    maxLines: 5, // Allows the field to be 5 lines high
                    minLines: 3, // Minimum height of the field
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Add Patient")),
          ],
        ),
      ),
    );
  }
}

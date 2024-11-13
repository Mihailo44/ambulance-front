import 'package:ambulance_app/model/users/unregistered_user.dart';
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
  final _additionalInformationController = TextEditingController();
  final List<String> _genders = ["Male", "Female"];
  String? _selectedGender = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _patientUsernameController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _yearOfBirthController.dispose();
    _additionalInformationController.dispose();
  }

  void _add() {
    if (_patientUsernameController.text.isNotEmpty) {
      widget.onAddPatient(_patientUsernameController.text);
      Navigator.pop(context);
    } else {
      showSnackBar(context, "Please enter patients ID first");
    }
  }

  void _addUnregistered() {
    var patient = UnregisteredUser(
      firstname: _firstnameController.text.isNotEmpty
          ? _firstnameController.text
          : "unspecified",
      lastname: _lastnameController.text.isNotEmpty
          ? _lastnameController.text
          : "unspecified",
      age: _yearOfBirthController.text.isNotEmpty
          ? _yearOfBirthController.text
          : "unspecified",
      gender: _selectedGender,
      additionalInfo: _additionalInformationController.text.isNotEmpty
          ? _additionalInformationController.text
          : "unspecified",
    );

    Navigator.pop(context, patient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        backgroundColor: const Color.fromARGB(255, 253, 253, 247),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
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
                          labelText: "Patient ID"),
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
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 5),
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
                              labelText: "Year of Birth"),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18, 24, 18, 0),
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
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12,22,12,40),
                      child: TextFormField(
                        controller: _additionalInformationController,
                        decoration: const InputDecoration(
                          labelText:
                              'Medical info, disabilities ...', //* neke bitne stvari stavi hintove, krvna grupa, invaliditet itd
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          alignLabelWithHint:
                              true, // Aligns the label to the top for multiline
                        ),
                        maxLines: 5,
                        minLines: 2,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                label: const Text("Add patient"),
                icon: const Icon(Icons.add),
                onPressed: () {
                  _addUnregistered();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
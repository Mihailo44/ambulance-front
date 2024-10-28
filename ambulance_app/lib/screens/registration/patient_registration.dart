import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/services/patient_service.dart';
import 'package:ambulance_app/util/dateFormater.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';

class PatientRegistration extends StatefulWidget {
  PatientRegistration({Key? key}) : super(key: key);

  @override
  State<PatientRegistration> createState() => PatientRegistrationState();
}

class PatientRegistrationState extends State<PatientRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _contactController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  DateTime? _pickedDate;
  // final _allergenController = TextEditingController();
  // final _allergyDescriptionController = TextEditingController();
  // final _medicationNameController = TextEditingController();
  // final _medicationDosageController = TextEditingController();

  final List<String> _genders = ["Male", "Female"];
  String? _selectedGender = "";

  final List<String> _bloodTypes = [
    "A-",
    "A+",
    "B-",
    "B+",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];
  String? _selectedBloodType = "";

  final List<String> _alergies = [""];

  final _patientService = PatientService();

  @override
  void dispose() {
    super.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _passwordController.dispose();
    _contactController.dispose();
    _emergencyContactController.dispose();
    // _allergenController.dispose();
    // _allergyDescriptionController.dispose();
    // _medicationNameController.dispose();
    // _medicationDosageController.dispose();
  }

  void _openDatePicker() {
    final now = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: DateTime(2000, now.month, now.day),
      firstDate: DateTime(1940, DateTime.january, DateTime.monday),
      lastDate: DateTime(now.year, now.month, now.day),
      initialEntryMode: DatePickerEntryMode.input,
    ).then((value) {
      setState(() {
        _pickedDate = value;
      });
    });
  }

  bool checkPasswordsMatching(){
    return _passwordController.text.trim() == _repeatPasswordController.text.trim();
  }

  Patient createPatient() {
    var newUser = User(
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        password: _passwordController.text,
        dateOfBirth: _pickedDate!,
        role: UserRole.PATIENT);

    var newPatient = Patient(
        user: newUser,
        contactNumber: _contactController.text,
        closePersonContact: _emergencyContactController.text,
        bloodType: _selectedBloodType!,
        gender: _selectedGender!,
        yearOfBirth: _pickedDate!.year.toString());

    return newPatient;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                const Row(
                  children: [
                    Text(
                      "Register your account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 15.0),
                          Row(
                            children: [
                              Expanded(child:
                              buildTextFormField(
                                  controller: _firstnameController,
                                  labelText: "Firstname"),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(child:
                              buildTextFormField(
                                  controller: _lastnameController,
                                  labelText: "Lastname"),),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _pickedDate == null
                                      ? "Date of Birth"
                                      : formatter.format(_pickedDate!),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton.icon(
                                label: const Text("Open"),
                                onPressed: () {
                                  _openDatePicker();
                                },
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          buildTextFormField(
                              controller: _contactController,
                              labelText: "Contact"),
                          const SizedBox(
                            height: 15.0,
                          ),
                          buildTextFormField(
                              controller: _emergencyContactController,
                              labelText: "Emergency Contact"),
                          const SizedBox(
                            height: 15.0,
                          ),
                          buildTextFormField(
                              controller: _passwordController,
                              labelText: "Password"),
                          const SizedBox(
                            height: 15.0,
                          ),
                          buildTextFormField(
                              controller: _repeatPasswordController,
                              labelText: "Repeat Password"),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DropdownButtonFormField<String>(
                              hint: const Text(
                                "Blood Type",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              items: [
                                for (final b in _bloodTypes)
                                  DropdownMenuItem(
                                      value: b,
                                      child: Text(
                                        b,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ))
                              ],
                              onChanged: (value) {
                                if(value == null){
                                  return;
                                }
                                setState(() {
                                  _selectedBloodType = value;
                                });
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
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
                          const SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(MediaQuery.of(context).size.width * 0.45, 60),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                
                                if(!checkPasswordsMatching()){
                                  showSnackBar(context, "Passwords must match!");
                                  return;
                                }

                                final newPatient = createPatient();
                                var isSuccessfull =
                                    await _patientService.register(newPatient);
                            
                                if (isSuccessfull) {
                                  showSnackBar(
                                    context,
                                    "You have registered successfully",
                                  );
                                } else {
                                  showSnackBar(
                                    context,
                                    "Registration failed",
                                  );
                                }
                              },
                              label: const Text("Register",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              ),
                              icon: const Icon(Icons.add),
                            ),
                          ),
                          const SizedBox(height: 15.0,),
                          // Container(
                          //   child: Column(
                          //     children: [
                          //       OutlinedButton.icon(
                          //         label: const Text("Add Allergies"),
                          //         icon: const Icon(Icons.add),
                          //         onPressed: () {
                          //           showDialog(
                          //               context: context,
                          //               builder: (BuildContext context) {
                          //                 return AlertDialog(
                          //                     title: const Text("New Allergy"),
                          //                     content: Container(
                          //                       height: MediaQuery.of(context)
                          //                               .size
                          //                               .height *
                          //                           0.5,
                          //                       width: MediaQuery.of(context)
                          //                               .size
                          //                               .width *
                          //                           0.85,
                          //                       child: Form(
                          //                           child: Column(
                          //                         children: [
                          //                           const SizedBox(
                          //                             height: 15.0,
                          //                           ),
                          //                           buildTextFormField(
                          //                               controller:
                          //                                   _allergenController,
                          //                               labelText: "Allergen"),
                          //                           const SizedBox(
                          //                             height: 15.0,
                          //                           ),
                          //                           buildTextFormField(
                          //                               controller:
                          //                                   _allergyDescriptionController,
                          //                               labelText:
                          //                                   "Description (optional)"),
                          //                           const SizedBox(
                          //                             height: 15.0,
                          //                           ),
                          //                           buildTextFormField(
                          //                               controller:
                          //                                   _medicationNameController,
                          //                               labelText:
                          //                                   "Medication Name"),
                          //                           const SizedBox(
                          //                             height: 15.0,
                          //                           ),
                          //                           buildTextFormField(
                          //                               controller:
                          //                                   _medicationDosageController,
                          //                               labelText: "Weekly Dosage"),
                          //                           const SizedBox(
                          //                             height: 15.0,
                          //                           ),
                          //                           ElevatedButton(
                          //                               onPressed: () {
                          //                                 Navigator.pop(context);
                          //                               },
                          //                               child: const Text("Add"))
                          //                         ],
                          //                       )),
                          //                     ));
                          //               });
                          //         },
                          //       ),
                          //    ],
                          //  ),
                          // )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

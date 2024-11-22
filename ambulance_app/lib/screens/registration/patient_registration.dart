import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/medication.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/screens/auth/account_activation_screen.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/services/patient_service.dart';
import 'package:ambulance_app/util/dateFormater.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';

class PatientRegistration extends StatefulWidget {
  const PatientRegistration({super.key});

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

  bool checkPasswordsMatching() {
    return _passwordController.text.trim() ==
        _repeatPasswordController.text.trim();
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

  Patient _setupDummyPatient() {
    User user = User(
        firstname: "p",
        lastname: "p",
        password: "sifra",
        dateOfBirth: DateTime.now().toUtc(),
        role: UserRole.PATIENT);

    List<Allergy> alergies = [
      Allergy(
          allergen: "ugly hoes",
          description:
              "Allergies are immune system reactions to substances that are typically harmless to most people, such as pollen, food, or medications. When exposed to an allergen, the body can produce symptoms ranging from mild (like sneezing or itching) to severe, potentially causing life-threatening anaphylaxis.",
          medications: [Medication(name: "Bromazepam", weeklyDosage: 3)]),
      Allergy(
          allergen: "fake niggas",
          description: "I just can't",
          medications: [Medication(name: "Hennessy", weeklyDosage: 12)])
    ];

    List<Disease> diseases = [
      Disease(name: "Jealosy", medications: []),
      Disease(name: "Revertiligo", medications: []),
      Disease(
          name: "Alcoholism",
          medications: [Medication(name: "Heroin", weeklyDosage: 3)]),
    ];

    Patient patient = Patient(
        user: user,
        contactNumber: "123",
        closePersonContact: "0616323221",
        bloodType: "A-",
        gender: "M",
        yearOfBirth: "2001",
        pastOperations: "Knee operation,Back surgery,Leg surgery",
        alergies: alergies,
        diseases: diseases);

    return patient;
  }

  void _register() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }

    // if (!checkPasswordsMatching()) {
    //   showSnackBar(context, "Passwords must match!");
    //   return;
    // }

    final navigator = Navigator.of(context);
    final newPatient = _setupDummyPatient();
    bool isSuccessfull = await _patientService.register(newPatient);

    if (!mounted) return;

    if (isSuccessfull) {
      showSnackBar(
        context,
        "You have registered successfully",
      );
      navigator.pop();
      navigator.push(MaterialPageRoute(
        builder: (ctx) => AccountActivationScreen(
          phoneNumber: newPatient.contactNumber,
        ),
      ));
    } else {
      showSnackBar(
        context,
        "Registration failed",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                SizedBox(
                  height: 55.0,
                  width: MediaQuery.of(context).size.width,
                ),
                Row(
                  children: [
                    Text("Register your account",
                        style: Theme.of(context).textTheme.bodyLarge)
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
                              Expanded(
                                child: buildTextFormField(
                                    controller: _firstnameController,
                                    labelText: "Firstname"),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: buildTextFormField(
                                    controller: _lastnameController,
                                    labelText: "Lastname"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    _pickedDate == null
                                        ? "Date of Birth"
                                        : formatter.format(_pickedDate!),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
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
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          buildTextFormField(
                              controller: _contactController,
                              labelText: "Contact"),
                          buildTextFormField(
                              controller: _emergencyContactController,
                              labelText: "Emergency Contact"),
                          buildTextFormField(
                              controller: _passwordController,
                              labelText: "Password"),
                          buildTextFormField(
                              controller: _repeatPasswordController,
                              labelText: "Repeat Password"),
                          const SizedBox(
                            height: 10.0,
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
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedBloodType = value;
                                });
                              }),
                          const SizedBox(
                            height: 18.0,
                          ),
                          DropdownButtonFormField<String>(
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
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.45,
                                    60),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: _register,
                              label: const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              icon: const Icon(Icons.add),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
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

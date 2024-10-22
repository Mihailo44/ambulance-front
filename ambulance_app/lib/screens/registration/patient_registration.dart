import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:flutter/material.dart';

class PatientRegistration extends StatefulWidget{
  PatientRegistration({Key? key}):super(key: key);
  
  @override
  State<PatientRegistration> createState() => PatientRegistrationState();
}

class PatientRegistrationState extends State<PatientRegistration>{
  
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _contactController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _allergenController = TextEditingController();
  final _allergyDescriptionController = TextEditingController();
  final _medicationNameController = TextEditingController();
  final _medicationDosageController = TextEditingController();
 
  final List<String> _genders = ["M","F"];
  String?  _selectedGender;

  final List<String> _bloodTypes = ["A-","A+","B-","B+","AB+","AB-","O+","O-"];
  String? _selectedBloodType;

  final List<String> _alergies = [""];

  @override
  void dispose() {
    super.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    _contactController.dispose();
    _emergencyContactController.dispose();
    _allergenController.dispose();
    _allergyDescriptionController.dispose();
    _medicationNameController.dispose();
    _medicationDosageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Material(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  buildTextFormField(
                      controller: _firstnameController, labelText: "Firstname"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextFormField(
                      controller: _lastnameController, labelText: "Lastname"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextFormField(
                      controller: _passwordController, labelText: "Password"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextFormField(
                      controller: _dateOfBirthController,
                      labelText: "Date Of Birth"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextFormField(
                    controller: _contactController, 
                    labelText: "Contact"
                  ),
                  const SizedBox(height: 15.0,),
                  buildTextFormField(controller: _emergencyContactController, labelText: "Emergency Contact"),
                  const SizedBox(height: 15.0,),
                  DropdownButtonFormField<String>(
                    hint: const Text("Blood Type"),
                    items: [
                      for(final b in _bloodTypes)
                        DropdownMenuItem(
                          value: b,
                          child: Container(
                            child: Text(b),
                          )
                        )
                    ], 
                    onChanged: (values){}
                    ),
                  const SizedBox(height: 15.0,),
                  DropdownButtonFormField<String>(
                    hint: const Text("Gender"),
                    onChanged: (value) {},
                    items: [
                      for (final g in _genders)
                        DropdownMenuItem(
                          value: g,
                          child: Container(
                            child: Text(g),
                          )
                        )
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                  Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            showDialog(
                              context: context, 
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: const Text("New Allergy"),
                                  content: Container(
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    width: MediaQuery.of(context).size.width * 0.85,
                                    child: Form(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 15.0,),
                                          buildTextFormField(controller: _allergenController, labelText: "Allergen"),
                                          const SizedBox(height: 15.0,),
                                          buildTextFormField(controller: _allergyDescriptionController, labelText: "Description (optional)"),
                                          const SizedBox(height: 15.0,),
                                          buildTextFormField(controller: _medicationNameController, labelText: "Medication Name"),
                                          const SizedBox(height: 15.0,),
                                          buildTextFormField(controller: _medicationDosageController, labelText: "Weekly Dosage"),
                                          const SizedBox(height: 15.0,),
                                          ElevatedButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            }, 
                                            child: const Text("Add")
                                          )
                                        ],
                                      )
                                      ),
                                  )
                                );
                              }
                            );
                          }, 
                          child: const Text("Add Allergy")
                        ),
                        ListView(

                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
        ),
      );
  }

}
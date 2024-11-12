import 'dart:developer';
import 'package:ambulance_app/screens/tables/all_operating_bases.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  //final _roleController = TextEditingController();

  final List<String> _dropdownOptions = [
    "Dispatcher",
    "Medical Evaluator",
    "Vehicle Operator"
  ];
  String? _selectedOption;

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _firstnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Firstname is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Firstname"),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _lastnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lastname is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Lastname"),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText:
                            "Password"), //sifru treba da promene prvi put kad se uloguju
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Date of birth"),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: AllOperatingBases(),
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text("Add Operating Base"),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _register();
                      }
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

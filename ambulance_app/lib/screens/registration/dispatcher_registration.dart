import 'dart:developer';

import 'package:flutter/material.dart';

class DispatcherRegistration extends StatefulWidget{
  @override
 _DispatcherRegistrationState createState() => _DispatcherRegistrationState();
}

class _DispatcherRegistrationState extends State<DispatcherRegistration>{
  
  final List<String> _dropdownOptions = ["Dispatcher","Medical Evaluator","Vehicle Operator"];
  String? _selectedOption;
  
  void _register(){
    log("treba");
  }

  void _addOperatingBase(){
    log("ne treba");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.4,
            child: Form(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Firstname"),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Lastname"),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Username"), //ovo treba da im se generise 
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"), //sifru treba da promene prvi put kad se uloguju
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Date of birth"),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    items: _dropdownOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _addOperatingBase,
                    child: Text("Operating Base"),
                    ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _register,
                    child: Text("Register"),
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
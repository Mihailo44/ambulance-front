import 'dart:developer';

import 'package:flutter/material.dart';

class VehicleRegistration extends StatefulWidget{
  @override
  _VehicleRegistrationState createState() => _VehicleRegistrationState();
}

class _VehicleRegistrationState extends State<VehicleRegistration>{

  void _register(){
    log("register");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "License plate"),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  decoration: InputDecoration(labelText: "Jos nesto"),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: _register,
                  child: Text("Create"),  
                ),
              ],
            ),
          ),
        ),
    );
  }
}
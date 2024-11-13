import 'package:flutter/material.dart';

class OperatingBaseRegistration extends StatefulWidget{
  @override
  _OperatingBaseRegistrationState createState() => _OperatingBaseRegistrationState();
}

class _OperatingBaseRegistrationState extends State<OperatingBaseRegistration>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: ""),
              ),
              TextFormField(
              ),
            ],
          ),
        ),
      ),
    );
  }
}
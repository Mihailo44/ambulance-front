import 'dart:developer';

import 'package:flutter/material.dart';

class AddressRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddressRegistration();
}

class _AddressRegistration extends State<AddressRegistration>{

  void _create(){
    log("kreiraj");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Country"),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(labelText: "City"),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(labelText: "Street"),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(labelText: "Number"),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _create,
                child: Text("Add Address"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
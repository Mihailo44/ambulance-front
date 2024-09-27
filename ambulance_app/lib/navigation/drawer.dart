// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ambulance_app/screens/registration/medical_evaluator_registration.dart';
import 'package:ambulance_app/screens/registration/user_registration.dart';
import 'package:flutter/material.dart';

class MyNavigationDrawer extends StatefulWidget{
  const MyNavigationDrawer({super.key});

  @override
  _MyNavigationDrawerState createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer>{

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
           const SizedBox(
            height: 70.0,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text("App header"),
            ),
          ),
          ListTile(
            title: const Text("Medical Evaluator Registration"),
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MedicalEvaluatorRegistration()));
            },
          ),
          ListTile(title: Text("proba")),
        ],
      ),
    );
  }
}
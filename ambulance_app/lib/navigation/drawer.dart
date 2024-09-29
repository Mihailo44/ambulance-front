// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ambulance_app/navigation/screen_navigation.dart';
import 'package:ambulance_app/screens/home/home.dart';
import 'package:ambulance_app/screens/registration/medical_evaluator_registration.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

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
            onTap: () {
              context.go("/evaluator_registration");
              //Navigator.pop(context);
            },
          ),
          ListTile(title: Text("proba")),
        ],
      ),
    );
  }
}

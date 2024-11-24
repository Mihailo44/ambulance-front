// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ambulance_app/services/auth_service.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavDrawer extends StatelessWidget {

  NavDrawer({super.key});
<<<<<<< HEAD
=======
  
  final AuthService _authService = AuthService();
>>>>>>> main

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
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              //_authService.logout();
              showSnackBar(context, "You've been logged out");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

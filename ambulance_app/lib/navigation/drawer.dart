// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ambulance_app/services/auth_service.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavDrawer extends StatelessWidget {

  final AuthService _authService = AuthService();
  final StatefulNavigationShell navigationShell;

 NavDrawer(this.navigationShell, {Key? key}) : super(key: key);

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
              navigationShell.goBranch(0);
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

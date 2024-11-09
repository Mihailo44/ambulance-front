import 'package:ambulance_app/screens/auth/login_screen.dart';
import 'package:ambulance_app/screens/home/patient_home_screen.dart';
import 'package:ambulance_app/screens/profile/patient_profile.dart';
import 'package:flutter/material.dart';

class ScaffoldForMobile extends StatefulWidget {
  const ScaffoldForMobile({super.key});

  @override
  State<ScaffoldForMobile> createState() => _ScaffoldForMobileState();
}

class _ScaffoldForMobileState extends State<ScaffoldForMobile> {
  final double bottomBarHeight = 56;
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Zovi Hitnu",
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            offset: const Offset(0, 50),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  padding: const EdgeInsets.fromLTRB(20, 0, 30, 2),
                  height: 45,
                  labelTextStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.bodySmall),
                  value: "Settings",
                  onTap: () {},
                  child: const Text("Settings"),
                ),
                PopupMenuItem(
                  padding: const EdgeInsets.fromLTRB(20, 0, 30, 2),
                  height: 45,
                  labelTextStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.bodySmall),
                  value: "Logout",
                  onTap: () {
                   Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const LoginPage()),
  (Route<dynamic> route) => false, // This removes all previous routes
);

                  },
                  child: const Text("Logout"),
                )
              ];
            },
          )
        ],
      ),
      body: currentTab == 0 ? const PatientHomePage() : const PatientProfile(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.amber,
        onTap: (index) {
          switch (index) {
            case 0:
              if (currentTab != 0) {
                setState(() {
                  currentTab = 0;
                });
                //TODO riverPod stavi na home page
                //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ScaffoldForMobile()));
              }
            case 1:
              if (currentTab != 1) {
                setState(() {
                  currentTab = 1;
                });
              }
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

import 'package:ambulance_app/navigation/routes.dart';
import 'package:ambulance_app/screens/home/patient_home_screen.dart';
import 'package:ambulance_app/screens/profile/patient_profile.dart';
import 'package:flutter/material.dart';

class ScaffoldForMobile extends StatelessWidget {
  const ScaffoldForMobile({super.key});

  final double bottomBarHeight = 56;

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
            //onSelected: (value) => print(value),
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
                    router.replace("/login");
                  },
                  child: const Text("Logout"),
                )
              ];
            },
          )
        ],
      ),
      body: const PatientHomePage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.amber,
        onTap: (index) {
          switch(index){
            case 0:
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const PatientHomePage()));
            case 1:
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const PatientProfile()));
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

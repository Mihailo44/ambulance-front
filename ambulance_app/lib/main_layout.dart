import 'package:ambulance_app/navigation/drawer.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  
  const ScaffoldWithDrawer(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

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
         IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.menu),),
        ],

      ),
      body: navigationShell, // Displays the current tab's content
      drawer: kIsWeb ? NavDrawer(navigationShell) : null,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.amber,
          currentIndex: navigationShell.currentIndex,
          onTap: (index) {
            print(MediaQuery.of(context).size.height);
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,  
            );
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

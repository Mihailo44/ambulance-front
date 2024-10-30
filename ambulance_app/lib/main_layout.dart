import 'package:ambulance_app/navigation/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithDrawer(this.navigationShell, {Key? key}) : super(key: key);

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
      //   bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: navigationShell.currentIndex,
      //     onTap: (index) {
      //       navigationShell.goBranch(index);
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Feed',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.shop),
      //         label: 'Shop',
      //       ),
      //     ],
      //   ),
    );
  }
}

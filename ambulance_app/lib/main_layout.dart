import 'package:ambulance_app/navigation/drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithDrawer(this.navigationShell, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Zovi Hitnu"),
      ),
      body: navigationShell, // Displays the current tab's content
      drawer: NavDrawer(navigationShell),
      //   bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: navigationShell.currentIndex,
      //     onTap: (index) {
      //       // Switch tabs when the user taps on a BottomNavigationBar item
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

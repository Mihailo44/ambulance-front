import 'package:ambulance_app/navigation/drawer.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  const ScaffoldWithDrawer(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  bool _isNonoRoute(String route) {
    const nonoRoutes = [
      "/login",
      "/patient-registration",
      "/ambulance-request"
    ];

    if (nonoRoutes.contains(route)) {
      return true;
    }

    return false;
  }

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
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: navigationShell,
      drawer: kIsWeb ? NavDrawer(navigationShell) : null,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: router.routeInformationProvider,
          builder: (ctx, routeName, _) {
            var currentRoute = router.routeInformationProvider.value.uri.toString();
    
            return kIsWeb || _isNonoRoute(currentRoute)
                ? const SizedBox.shrink() : BottomNavigationBar(
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.amber,
                    currentIndex: navigationShell.currentIndex,
                    onTap: (index) {
                      //print(router.routeInformationProvider.value.uri);
                      navigationShell.goBranch(
                        index,
                        initialLocation: index == navigationShell.currentIndex,
                      );
                      //print(router.routeInformationProvider.value.uri);
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
                  );
          }),
    );
  }
}

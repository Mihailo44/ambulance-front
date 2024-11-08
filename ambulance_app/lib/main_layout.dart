import 'package:ambulance_app/navigation/drawer.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  ScaffoldWithDrawer(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  final double bottomBarHeight = 56;

  static const nonoRoutes = [
    "/login",
    "/patient-registration",
    "/ambulance-request",
    "/questions",
    "/patients"
  ];

  bool _isNonoRoute(String route) {
    return nonoRoutes.contains(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isNonoRoute(router.routeInformationProvider.value.uri.toString()) ? null :
      AppBar(
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

      body: navigationShell,
  
      drawer: kIsWeb ? NavDrawer(navigationShell) : null,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: router.routeInformationProvider,
          builder: (ctx, routeName, _) {
            var currentRoute = GoRouter.of(context).routeInformationProvider.value.uri.toString();

            return kIsWeb || _isNonoRoute(currentRoute)
                ? const SizedBox.shrink()
                : BottomNavigationBar(
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

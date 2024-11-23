import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/providers/service_provider.dart';
import 'package:ambulance_app/screens/auth/login_screen.dart';
import 'package:ambulance_app/screens/home/patient_home_screen.dart';
import 'package:ambulance_app/screens/profile/patient_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldForMobile extends ConsumerStatefulWidget {
  const ScaffoldForMobile({super.key});

  @override
  ConsumerState<ScaffoldForMobile> createState() => _ScaffoldForMobileState();
}

class _ScaffoldForMobileState extends ConsumerState<ScaffoldForMobile> {
  final double bottomBarHeight = 56;
  int _currentTab = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> _pages = [
    const PatientHomeScreen(),
    const PatientProfile(),
  ];

  void _selectTab(int idx) {
    final isVisible = ref.read(appBarVisibilityProvider);

    if (_currentTab != idx) {
      var previousTab = _currentTab;
      setState(() {
        _currentTab = idx;
      });

      if (!_navigatorKeys[previousTab].currentState!.canPop() &&
          !_navigatorKeys[_currentTab].currentState!.canPop()) {
        if (!isVisible) {
          ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
        }
      } else if (_navigatorKeys[previousTab].currentState!.canPop() &&
          !_navigatorKeys[_currentTab].currentState!.canPop()) {
        ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
      } else if (!_navigatorKeys[previousTab].currentState!.canPop() &&
          _navigatorKeys[_currentTab].currentState!.canPop()) {
        ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
      } else {
        if (isVisible) {
          ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
        }
      }
    } else {
      if (_navigatorKeys[idx].currentState!.canPop()) {
        _navigatorKeys[idx].currentState!.popUntil((route) => route.isFirst);
        ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
      }
    }
  }

  //? da li logout treba da bude async
  void _logout() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );

    await ref.read(authServiceProvider).logout();
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = ref.watch(appBarVisibilityProvider);

    return Scaffold(
      appBar: !isVisible
          ? null
          : AppBar(
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
                        labelTextStyle: WidgetStatePropertyAll(Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 19)),
                        value: "Settings",
                        onTap: () {},
                        child: const Text("Settings"),
                      ),
                      PopupMenuItem(
                        padding: const EdgeInsets.fromLTRB(20, 0, 30, 2),
                        height: 45,
                        labelTextStyle: WidgetStatePropertyAll(
                          Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 19),
                        ),
                        value: "Logout",
                        onTap: _logout,
                        child: const Text("Logout"),
                      )
                    ];
                  },
                )
              ],
            ),
      body: Stack(
        children: _pages.asMap().entries.map((entry) {
          int idx = entry.key;
          Widget page = entry.value;

          return Offstage(
            offstage: _currentTab != idx,
            child: Navigator(
              key: _navigatorKeys[idx],
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(builder: (ctx) => page);
              },
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: !isVisible
          ? null
          : BottomNavigationBar(
              currentIndex: _currentTab,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.amber,
              onTap: (index) {
                switch (index) {
                  case 0:
                    _selectTab(0);
                  case 1:
                    _selectTab(1);
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

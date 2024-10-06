import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/main_layout.dart';
import 'package:ambulance_app/screens/auth/login_screen.dart';
import 'package:ambulance_app/screens/home/home.dart';
import 'package:ambulance_app/screens/registration/medical_evaluator_registration.dart';
import 'package:ambulance_app/screens/tables/all_operating_bases.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (BuildContext context, state) {
    if (accessToken.isEmpty) {
      return '/login';
    } else {
      return null;
    }
  },
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
        // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
        return ScaffoldWithDrawer(navigationShell);
      },
      branches: [
        // The route branch for the 1º Tab
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          // Add this branch routes
          // each routes with its sub routes if available e.g feed/uuid/details
          routes: <RouteBase>[
            GoRoute(
              path: "/login",
              builder: (context, state) => LoginPage(),
            ),
            GoRoute(
              path: '/',
              builder: (context, state) => HomePage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'evaluator_registration',
                  builder: (context, state) => MedicalEvaluatorRegistration(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'all_bases',
                      builder: (context, state) => AllOperatingBases(),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

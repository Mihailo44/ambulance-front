import 'package:ambulance_app/screens/auth/account_activation_screen.dart';
import 'package:ambulance_app/screens/auth/login_screen.dart';
import 'package:ambulance_app/screens/registration/patient_registration.dart';
import 'package:ambulance_app/screens/tables/all_operating_bases.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  // redirect: (BuildContext context, state) {
  //   if (accessToken.isEmpty) {
  //     return '/login';
  //   } else {
  //     return null;
  //   }
  // },
  observers: [
    
  ],
  routes: <RouteBase>[
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
      GoRoute(
        path: "/patient-registration",
        builder: (context, state) => const PatientRegistration(),
      ),
  ],
);

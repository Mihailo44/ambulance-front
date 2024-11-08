import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/main_layout.dart';
import 'package:ambulance_app/model/question.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/navigation/observer.dart';
import 'package:ambulance_app/screens/auth/account_activation_screen.dart';
import 'package:ambulance_app/screens/auth/login_screen.dart';
import 'package:ambulance_app/screens/home/patient_home_screen.dart';
import 'package:ambulance_app/screens/profile/patient_profile.dart';
import 'package:ambulance_app/screens/questions/patients_list.dart';
import 'package:ambulance_app/screens/questions/questions_screen.dart';
import 'package:ambulance_app/screens/questions/trauma_type_screen.dart';
import 'package:ambulance_app/screens/registration/medical_evaluator_registration.dart';
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
    MyNavigatorObserver(),
  ],
  routes: <RouteBase>[
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
          path: "/",
          builder: (ctx, state) {
            return PatientHomePage();
          },
          routes: [
            GoRoute(
                path: "questions",
                builder: (ctx, state) {
                  final traumaType = parseTraumaType(state.extra as String);
                  return QuestionsScreen(traumaCause: traumaType);
                }),
            GoRoute(
              path: "ambulance-request",
              builder: (ctx, state) => TraumaTypeScreen(),
            ),
            GoRoute(
                path: "patients",
                builder: (ctx, state) {
                  return VictimList();
                }),
          ],
        ),
      GoRoute(
        path: "/patient-registration",
        builder: (context, state) => const PatientRegistration(),
      ),
      GoRoute(
        path: "/account-activation",
        builder: (ctx, state) => const AccountActivationScreen(),
      ),
      GoRoute(
          path: "/profile",
          builder: (ctx, state) => const PatientProfile(),
        )
  ],
);

const role = UserRole.PATIENT;
//* deklarisi listu ruti za prvi branch, i drugi
List<StatefulShellBranch> _loggedRoleRoutes() {
  switch (role) {
    case UserRole.PATIENT:
      return _getPatientRoutes();
    case UserRole.ADMIN:
      return [];
    case UserRole.DISPATCHER:
      return [];
    case UserRole.MEDICAL_EVALUATOR:
      return [];
    case UserRole.VEHICLE_OPERATOR:
      return [];
    default:
      return _getPatientRoutes();
  }
}

List<StatefulShellBranch> _getPatientRoutes() {
  final routes = <StatefulShellBranch>[
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: "/profile",
          builder: (ctx, state) => const PatientProfile(),
        )
        // GoRoute(path: "/trauma",pageBuilder: (ctx,state) {
        //   return getPage(child: TraumaTypeScreen(), state: state);
        // })
      ],
    )
  ];

  return routes;
}
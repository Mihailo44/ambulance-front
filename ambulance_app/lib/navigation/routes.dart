import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/main_layout.dart';
import 'package:ambulance_app/model/question.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/screens/auth/login_screen.dart';
import 'package:ambulance_app/screens/home/patient_home_screen.dart';
import 'package:ambulance_app/screens/profile/patient_profile.dart';
import 'package:ambulance_app/screens/questions/questions_screen.dart';
import 'package:ambulance_app/screens/questions/trauma_type_screen.dart';
import 'package:ambulance_app/screens/registration/medical_evaluator_registration.dart';
import 'package:ambulance_app/screens/registration/patient_registration.dart';
import 'package:ambulance_app/screens/tables/all_operating_bases.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  // redirect: (BuildContext context, state) {
  //   if (accessToken.isEmpty) {
  //     return '/login';
  //   } else {
  //     return null;
  //   }
  // },
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
        // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
        return ScaffoldWithDrawer(navigationShell);
      },
      branches: [
        ..._loggedRoleRoutes(),
      ],
    ),
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
      navigatorKey: _sectionNavigatorKey,
      // Add this branch routes
      // each routes with its sub routes if available e.g feed/uuid/details
      routes: <RouteBase>[
        //* onu rutu koju ovde stavis prvu na nju vodi navigationShell.goBranch()
        GoRoute(
          path: "/home",
          builder: (ctx, state) {
            //* if user is patient
            return const PatientHomePage();
          },
        ),
        GoRoute(
          path: "/login",
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: "/patient-registration",
          builder: (context, state) => const PatientRegistration(),
        ),
        GoRoute(
          path: "/ambulance-request",
          builder: (ctx, state) => TraumaTypeScreen(),
          routes: [
            GoRoute(
              path: "questions",
              builder: (ctx, state) {
                  final traumaType = parseTraumaType(state.extra as String);
                  return QuestionsScreen(traumaCause: traumaType);
              }
            )
          ],
        ),
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const HomePage(),
        //   routes: <RouteBase>[
        //     GoRoute(
        //       path: 'evaluator_registration',
        //       builder: (context, state) => MedicalEvaluatorRegistration(),
        //       routes: <RouteBase>[
        //         GoRoute(
        //           path: 'all_bases',
        //           builder: (context, state) => AllOperatingBases(),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ],
    ),
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

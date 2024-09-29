import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/screens/home/home.dart';
import 'package:ambulance_app/screens/registration/medical_evaluator_registration.dart';
import 'package:ambulance_app/screens/tables/all_operating_bases.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routes = [
  GoRoute(
    name: "home",
    path: "/",
    pageBuilder: (context, state) =>
        MaterialPage(key: state.pageKey, child: HomeScreen()),
    routes: [
      GoRoute(
        name: "medicalEvaluatorRegistration",
        path: "evaluator_registration",
        pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey, child: MedicalEvaluatorRegistration()),
      ),
    ],
  ),
  GoRoute(
    name: "allOperatingBases",
    path: "/all_bases",
    pageBuilder: (context, state) =>
        MaterialPage(key: state.pageKey, child: AllOperatingBases()),
  ),
];

final GoRouter router = GoRouter(
  routes: routes,
  errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey, child: ErrorPage(state.error.toString())),
);

Widget getScreen(String screen) {
  switch (screen) {
    case "medicalEvaluatorRegistration":
      return MedicalEvaluatorRegistration();
    case "allOperatingBases":
      return AllOperatingBases();
    default:
      return HomePage();
  }
}

class ErrorPage extends StatelessWidget {
  final String error;
  const ErrorPage(this.error);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: Center(
        child: SelectableText("Error: $error"),
      ),
    );
  }
}

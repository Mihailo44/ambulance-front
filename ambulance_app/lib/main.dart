import 'package:ambulance_app/model/users/basic_user_info.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

String accessTokenExpiry = "";
String accessToken = "";
BasicUserInfo? basicUser;
User? loggedUser;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Zovi Hitnu",
      //routerConfig: kIsWeb ? router : null,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

import 'package:ambulance_app/model/basic_user_info.dart';
import 'package:ambulance_app/model/user.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:flutter/foundation.dart';
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
      title: "Ambulance App",
      //routerConfig: kIsWeb ? router : null,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

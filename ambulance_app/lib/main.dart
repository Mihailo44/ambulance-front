import 'package:ambulance_app/screens/dummy.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Zovi Hitnu'),
        ),
        body: UserButton(),
      )
    );
  }
}

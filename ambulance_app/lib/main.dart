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
          title: const Text('Zovi Hitnu'),
        ),
        body: LoginPage(),
      )
    );
  }
}

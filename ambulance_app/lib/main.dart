import 'package:ambulance_app/navigation/drawer.dart';
import 'package:ambulance_app/screens/home/home.dart';
import 'package:ambulance_app/screens/registration/user_registration.dart';
import 'package:ambulance_app/screens/tables/all_operating_bases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

final FlutterSecureStorage secureStorage = new FlutterSecureStorage();
String accessToken="";

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
        body: HomeScreen(),
        drawer:  MyNavigationDrawer(),
      )
    );
  }
}

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  Widget _currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: _currentScreen,
      ),
    );
  }
}

import 'package:ambulance_app/navigation/drawer.dart';
import 'package:ambulance_app/screens/home/home.dart';
import 'package:ambulance_app/screens/registration/user_registration.dart';
import 'package:ambulance_app/screens/tables/all_operating_bases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

final FlutterSecureStorage secureStorage = FlutterSecureStorage();
String accessToken="";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Demo",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  Widget _currentScreen = HomePage();

  void _onSelectScreen(Widget screen){
    setState(() {
      _currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Zovi Hitnu"),
      ),
      body: Center(
        child: _currentScreen,
      ),
      drawer: NavDrawer(onSelectScreen: _onSelectScreen),
    );
  }
}

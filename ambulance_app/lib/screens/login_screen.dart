import 'dart:developer';

import 'package:ambulance_app/screens/registration/dispatcher_registration.dart';
import 'package:ambulance_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isLoading = false;

  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = new FlutterSecureStorage();

  void _mockLogin(){
    log("ulogovao se");
    setState(() {
        _isLoading = false;
      });
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

      final response = await _authService.login(_username, _password);      

      if(!response.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successfull"))
        );
        await _secureStorage.write(key: 'access_token', value: response['access_token']);
        await _secureStorage.write(key: 'refresh_token', value: response['refresh_token']);

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login unsuccessfull please try again"))
        );
      }

        setState(() {
          _isLoading = false;
        });

        Navigator.push(context,
          MaterialPageRoute(builder: (context)=>  DispatcherRegistration())
        );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _username = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) {
                  _password = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text('Login'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

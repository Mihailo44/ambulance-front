import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/question.dart';
import 'package:ambulance_app/screens/questions/questions_screen.dart';
import 'package:ambulance_app/screens/questions/trauma_type_screen.dart';
import 'package:ambulance_app/screens/registration/patient_registration.dart';
import 'package:ambulance_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isLoading = false;

  final _authService = AuthService();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

      var _ = await _authService.login(_username, _password);

      if (accessToken.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login successfull"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
            content: Text("Login failed please try again"),
          ),
        );
      }

      setState(() {
        _isLoading = false;
        context.go("/");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.65,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    fontSize: 22,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 20,
                ),
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
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 22,
                  ),
                ),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientRegistration()),
                    );
                  },
                  child: const Text("Register")),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TraumaTypeScreen()),
                    );
                  },
                  child: const Text("Trauma"))
            ],
          ),
        ),
      ),
    );
  }
}

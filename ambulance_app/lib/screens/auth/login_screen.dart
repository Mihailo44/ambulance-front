import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/screens/questions/add_patient_screen.dart';
import 'package:ambulance_app/screens/questions/trauma_type_screen.dart';
import 'package:ambulance_app/screens/questions/victims_list.dart';
import 'package:ambulance_app/screens/registration/patient_registration.dart';
import 'package:ambulance_app/services/auth_service.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

      var _ = await _authService.login(
          _usernameController.text, _passwordController.text);

      if (accessToken.isNotEmpty) {
        context.go("/");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed please try again"),
          ),
        );
      }

      setState(() {
        _isLoading = false;
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
              buildTextFormField(
                controller: _usernameController,
                labelText: "Username",
              ),
              const SizedBox(
                height: 10,
              ),
              buildTextFormField(
                controller: _passwordController,
                labelText: "Password",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientRegistration()),
                  );
                },
                child: const Text("Register"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VictimList()),
                  );
                },
                child: const Text("Victims"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

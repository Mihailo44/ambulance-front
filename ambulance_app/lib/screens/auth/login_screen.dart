import 'package:ambulance_app/main_layout.dart';
import 'package:ambulance_app/providers/mock_patient_provider.dart';
import 'package:ambulance_app/providers/service_provider.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/screens/registration/patient_registration.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/inactivity_wrapper.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _setupDummyPatient() {
    ref.read(patientProvider.notifier).setPatient(ref.read(mockPatient));
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

      final nav = Navigator.of(context);
      final authService = ref.read(authServiceProvider);
      bool response = await authService.login(
          _usernameController.text, _passwordController.text);

      // nav.pushReplacement(MaterialPageRoute(builder: (ctx) => const InactivityWrapper(child: ScaffoldForMobile())));
      if (response) {
        //router.go("/");
        nav.pushReplacement(MaterialPageRoute(
            builder: (ctx) =>
                const InactivityWrapper(child: ScaffoldForMobile())));
      } else {
        showSnackBar(context, "Login failed please try again");
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:  _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FractionallySizedBox(
            widthFactor: 0.65,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  const SizedBox(height: 30),
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
                            builder: (context) =>
                                const PatientRegistration()),
                      );
                    },
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _setupDummyPatient();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (ctx) => const ScaffoldForMobile()));
                    },
                    child: const Text("Home"),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

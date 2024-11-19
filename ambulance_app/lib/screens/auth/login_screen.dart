import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/main_layout.dart';
import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/medication.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/screens/questions/location_dialog_screen.dart';
import 'package:ambulance_app/screens/registration/patient_registration.dart';
import 'package:ambulance_app/services/auth_service.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
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
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _setupDummyPatient() {
    User user = User(
        firstname: "Boban",
        lastname: "Rajovic",
        password: "Rerna",
        dateOfBirth: DateTime.now(),
        role: UserRole.PATIENT);

    List<Allergy> alergies = [
      Allergy(
          allergen: "ugly hoes",
          description:
              "Allergies are immune system reactions to substances that are typically harmless to most people, such as pollen, food, or medications. When exposed to an allergen, the body can produce symptoms ranging from mild (like sneezing or itching) to severe, potentially causing life-threatening anaphylaxis.",
          medications: [Medication(name: "Bromazepam", weeklyDosage: 3)]),
      Allergy(
          allergen: "fake niggas",
          description: "I just can't",
          medications: [Medication(name: "Hennessy", weeklyDosage: 12)])
    ];

    List<Disease> diseases = [
      Disease(name: "Jealosy", medications: []),
      Disease(name: "Revertiligo", medications: []),
      Disease(
          name: "Alcoholism",
          medications: [Medication(name: "Heroin", weeklyDosage: 3)]),
    ];

    Patient patient = Patient(
        user: user,
        contactNumber: "061/623-49-33",
        closePersonContact: "061/632-32-21",
        bloodType: "A-",
        gender: "M",
        yearOfBirth: "2001",
        pastOperations: "Knee operation,Back surgery,Leg surgery",
        alergies: alergies,
        diseases: diseases);


    ref.read(patientProvider.notifier).setPatient(patient);
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
        router.go("/");
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
    return Material(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
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
                   // _setupDummyPatient();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const ScaffoldForMobile()));
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

import 'package:ambulance_app/model/users/medical_evaluator.dart';
import 'package:ambulance_app/model/operating_base.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/services/admin_service.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MedicalEvaluatorRegistration extends StatefulWidget {
  MedicalEvaluatorRegistration({Key? key}) : super(key: key);

  @override
  MedicalEvaluatorRegistrationState createState() =>
      MedicalEvaluatorRegistrationState();
}

class MedicalEvaluatorRegistrationState
    extends State<MedicalEvaluatorRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  OperatingBase? _selectedOperatingBase;
  final _adminService = AdminService();

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerEvaluator() async{
      User user = User(
          id: -1,
          firstname: _firstnameController.value.text,
          lastname: _lastnameController.value.text,
          username: "username",
          password: _passwordController.value.text,
          dateOfBirth:
              DateTime.parse(_dateOfBirthController.value.text),
          role: UserRole.MEDICAL_EVALUATOR);

      MedicalEvaluator evaluator = MedicalEvaluator(
          userId: -1,
          user: user,
          operatingBaseId: _selectedOperatingBase!.id,
          operatingBase: _selectedOperatingBase!);

        final response = _adminService.registerEvaluator(evaluator);

        if(await response){
          showSnackBar(context, "Evaluator created");
          context.go("/");
        }else{
          showSnackBar(context, "Failed to create");
        }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Center(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  buildTextFormField(
                      controller: _firstnameController, labelText: "Firstname"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextFormField(
                      controller: _lastnameController, labelText: "Lastname"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextFormField(
                      controller: _passwordController, labelText: "Password"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextFormField(
                      controller: _dateOfBirthController,
                      labelText: "Date Of Birth"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final OperatingBase selectedBase = await context
                                .push('/evaluator_registration/all_bases')
                            as OperatingBase;
                        if (selectedBase != null) {
                          setState(() {
                            _selectedOperatingBase = selectedBase;
                          });
                        }
                      },
                      child: const Text("Pick an operating base")),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                    onPressed: () {
                      _registerEvaluator();
                    },
                    child: const Text("Register"),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

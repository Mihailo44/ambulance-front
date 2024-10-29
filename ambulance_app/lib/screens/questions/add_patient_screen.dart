import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({required this.onAddPatient,super.key});

  final void Function(String patient) onAddPatient;

  @override
  State<AddPatientScreen> createState() => _StateAddPatientScreen();
}

class _StateAddPatientScreen extends State<AddPatientScreen> {
  final _victimUsernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _victimUsernameController.dispose();
  }

  void _add(){
    if(_victimUsernameController.text.isNotEmpty){
    widget.onAddPatient(_victimUsernameController.text);
    Navigator.pop(context);
    }else{
      showSnackBar(context, "Please enter patients ID first");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
          child: Text(
            "Please add a patient to the request",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
          child: Row(
            children: [
              Expanded(
                child: buildTextFormField(
                    controller: _victimUsernameController,
                    labelText: "Enter Patient ID"),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                label: const Text("Add patient"),
                icon: const Icon(Icons.add),
                onPressed: () {
                  _add();
                },
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.amber,
          height: 10,
          thickness: 2,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
            child: Text(
              "If you can't find patients ID, write all information you know below please",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Form(child: const Text("Ovde ce bidne forma"),),
      ],
    );
  }
}

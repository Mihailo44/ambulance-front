import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddOperationScreen extends ConsumerStatefulWidget {
  const AddOperationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddOperationScreenState();
}

class _AddOperationScreenState extends ConsumerState<AddOperationScreen>{

  final _nameController = TextEditingController();

  void _saveOperation(){
    ref.read(patientProvider.notifier).addOperation(_nameController.text);
    close(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: buildTextFormField(
                        controller: _nameController, labelText: "Name"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          close(context);
                          _nameController.clear();
                        },
                        label: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed:_saveOperation,
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
  
}
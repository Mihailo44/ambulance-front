import 'package:ambulance_app/generic_widgets/my_dialog.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/screens/patient_profile_managment/operation/edit_operation_screen.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:ambulance_app/util/close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationDetailsScreen extends ConsumerWidget {
  const OperationDetailsScreen({required this.name,super.key});

  final String name;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SizedBox(
      height: 330,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            buildFormattedTextField(context, "Operation type", name),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    close(context);
                    showModalBottomSheet(context: context, builder: (ctx) => EditOperationScreen(operation: name));
                  },
                  label: const Text("Edit"),
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton.icon(
                    onPressed: () async{
                      var nav = Navigator.of(context);
                      bool? result = await showDialog<bool>(context: context, builder: (ctx) => const MyDialog());
                      if(result != null && result == true){
                        ref.read(patientProvider.notifier).removeOperation(name);
                        nav.pop();
                      }
                    },
                    label: const Text("Delete"),
                    icon: const Icon(Icons.delete),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

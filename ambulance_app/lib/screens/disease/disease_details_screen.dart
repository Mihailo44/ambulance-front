import 'package:ambulance_app/generic_widgets/my_dialog.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter/material.dart';

class DiseaseDetailsScreen extends StatelessWidget {

  const DiseaseDetailsScreen({required this.onDelete,required this.disease,super.key});

  final Disease disease;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          buildFormattedTextField(context, "Disease", disease.name),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              "Medications",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          disease.medications.isEmpty
              ? const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('No medications'),
              )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: disease.medications.map((e) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Text(
                        "${e.name} x ${e.weeklyDosage} times",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  }).toList(),
                ),
          const Spacer(),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Edit"),
              icon: const Icon(Icons.edit),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: ElevatedButton.icon(
                onPressed: () async {
                  var nav = Navigator.of(context);
                  bool? result = await showDialog<bool>(context: context, builder: (ctx) => MyDialog(onYesParam: onDelete,param: disease.name,));
                  if(result != null && result == true){
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
    );
  }
  
}
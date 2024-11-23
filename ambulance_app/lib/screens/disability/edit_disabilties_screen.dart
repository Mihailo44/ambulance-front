import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/generic_widgets/my_dialog.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/disability.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditDisabiltiesScreen extends ConsumerStatefulWidget {
  const EditDisabiltiesScreen({super.key});

  @override
  ConsumerState<EditDisabiltiesScreen> createState() =>
      _EditDisabiltiesScreenState();
}

class _EditDisabiltiesScreenState extends ConsumerState<EditDisabiltiesScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  void _remove(Disability disability) async {
    final result = await showDialog<bool>(context: context, builder: (ctx) => const MyDialog());
    if(result != null && result == true){
      ref.read(patientProvider.notifier).removeDisability(disability);
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabilities = ref.watch(patientProvider)!.disabilites;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 14, 14),
      child: SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "Edit Disabilities",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 12,
              ),
              ...disabilities.map((e) {
                List<String> name = e.name.split("_");
                var result = name[0].substring(0, 1) +
                    name[0].substring(1).toLowerCase();
                return CustomListTile(
                  title: name.length == 1
                      ? result
                      : "$result ${name[1].toLowerCase()}",
                  onPressed: () {
                    _remove(e);
                  },
                  mode: Mode.delete,
                );
              }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: const Text("Close"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

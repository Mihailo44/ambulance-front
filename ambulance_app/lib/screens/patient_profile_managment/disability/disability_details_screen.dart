import 'package:ambulance_app/model/disability.dart';
import 'package:ambulance_app/screens/patient_profile_managment/disability/edit_disabilties_screen.dart';
import 'package:flutter/material.dart';

class DisabilityDetailsScreen extends StatelessWidget {
  const DisabilityDetailsScreen({required this.disabilites, super.key});

  final List<Disability> disabilites;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 14, 14),
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
            ),
            Text(
              "Disabilities",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 12,
            ),
            Column(
                children: disabilites.isEmpty
                    ? [
                        const Text("No disabilities")
                      ]
                    : [
                        ...disabilites.map((e) {
                          List<String> name = e.name.split("_");
                          var result = name[0].substring(0, 1) +
                              name[0].substring(1).toLowerCase();
                          return Text(name.length == 1
                              ? result
                              : "$result ${name[1].toLowerCase()}");
                        }),
                      ]),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const EditDisabiltiesScreen());
                },
                label: const Text("Edit"),
                icon: const Icon(Icons.edit),
              ),
            )
          ],
        ),
      ),
    );
  }
}

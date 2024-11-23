import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/screens/profile/update_user_info_screen.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final patient = ref.watch(patientProvider);
   
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 253, 253, 247),
        scrolledUnderElevation: 0,
        leading: IconButton(
            iconSize: 32,
            color: Colors.amber,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
                ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
              }
            }),
        title: Text(
          "Profile overview",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        //centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFormattedTextField(
                context, "Firstname", patient!.user!.firstname),
            buildFormattedTextField(
                context, "Lastname", patient.user!.lastname),
            buildFormattedTextField(context, "Year of Birth",
                patient.yearOfBirth.toString()),
            buildFormattedTextField(
                context, "Password", patient.user!.password),
            buildFormattedTextField(
                context, "Contact Number", patient.contactNumber),
            buildFormattedTextField(
                context, "Emergency Contact", patient.closePersonContact),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) =>
                          UpdateUserInfoScreen(patient: ref.read(patientProvider)!));
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit profile"),
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      minimumSize: const WidgetStatePropertyAll(Size(210, 62)),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

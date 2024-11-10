import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/screens/profile/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientProfile extends ConsumerWidget {
  const PatientProfile({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Activate Account"),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
            User user = User(firstname: "Mihailo", lastname: "Djajic", password: "Rerna", dateOfBirth: DateTime.now(),role: UserRole.PATIENT);
            Patient patient = Patient(user: user, contactNumber: "061/623-49-33", closePersonContact: "061/632-32-21", bloodType: "A-", gender: "M", yearOfBirth: "2001");

            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UserInfoScreen(patient: patient)));
          },
          child: const Text("User info"),
        ),
      ],
    );
  }
}

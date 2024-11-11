import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/medication.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/screens/auth/account_activation_screen.dart';
import 'package:ambulance_app/screens/profile/medical_info_screen.dart';
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AccountActivationScreen()));
          },
          child: const Text("Activate Account"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
            User user = User(firstname: "Mihailo", lastname: "Djajic", password: "Rerna", dateOfBirth: DateTime.now(),role: UserRole.PATIENT);
            Patient patient = Patient(user: user, contactNumber: "061/623-49-33", closePersonContact: "061/632-32-21", bloodType: "A-", gender: "M", yearOfBirth: "2001");

            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UserInfoScreen(patient: patient)));
          },
          child: const Text("User info"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
            User user = User(firstname: "Boban", lastname: "Rajovic", password: "Rerna", dateOfBirth: DateTime.now(),role: UserRole.PATIENT);
            
            List<Allergy> alergies = [
              Allergy(allergen: "ugly hoes", description: "Allergies are immune system reactions to substances that are typically harmless to most people, such as pollen, food, or medications. When exposed to an allergen, the body can produce symptoms ranging from mild (like sneezing or itching) to severe, potentially causing life-threatening anaphylaxis.",medications: [Medication(name: "Bromazepam", weeklyDosage: 3)]),
              Allergy(allergen: "fake niggas", description: "I just can't",medications: [Medication(name: "Hennessy", weeklyDosage: 12)])
            ];

            List<Disease> diseases = [
              Disease(name: "Jealosy",medications: []),
              Disease(name: "Revertiligo", medications: []),
              Disease(name: "Alcoholism", medications: [Medication(name: "Heroin", weeklyDosage: 3)]),
            ];

            Patient patient = Patient(user: user, contactNumber: "061/623-49-33", closePersonContact: "061/632-32-21", bloodType: "A-", gender: "M", yearOfBirth: "2001",pastOperations: "Knee operation",alergies: alergies,diseases: diseases);

            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MedicalInfoScreen(patient: patient)));
          },
          child: const Text("Show Medical Info"),
        ),
      ],
    );
  }
}

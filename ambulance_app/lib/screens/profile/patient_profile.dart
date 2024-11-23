import 'package:ambulance_app/generic_widgets/custom_card.dart';
import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/disability.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/medication.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/providers/disability_provider.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/screens/profile/medical_info_screen.dart';
import 'package:ambulance_app/screens/profile/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientProfile extends ConsumerWidget {
  const PatientProfile({super.key});

  Patient _setupDummyPatient(WidgetRef ref) {
    User user = User(
        firstname: "Miran",
        lastname: "Miran",
        password: "sifra",
        dateOfBirth: DateTime.now(),
        role: UserRole.PATIENT);

    List<Allergy> alergies = [
      Allergy(
          allergen: "Lemonade",
          description:
              "Allergies are immune system reactions to substances that are typically harmless to most people, such as pollen, food, or medications. When exposed to an allergen, the body can produce symptoms ranging from mild (like sneezing or itching) to severe, potentially causing life-threatening anaphylaxis.",
          medications: [Medication(name: "Bromazepam", weeklyDosage: 3)]),
      Allergy(
          allergen: "Apples",
          description: "I just can't",
          medications: [Medication(name: "Hennessy", weeklyDosage: 12)])
    ];

    List<Disease> diseases = [
      Disease(name: "Cold", medications: [
        Medication(name: "Ibuprofren", weeklyDosage: 3)
      ]),
      Disease(name: "Revertiligo", medications: []),
    ];

    Set<Disability> disabilites = {ref.read(disabilityProvider)[0]};

    Patient patient = Patient(
        user: user,
        contactNumber: "061/623-49-33",
        closePersonContact: "061/632-32-21",
        bloodType: "A-",
        gender: "M",
        yearOfBirth: "2001",
        pastOperations: "Knee operation,Back surgery,Leg surgery",
        alergies: alergies,
        diseases: diseases,
        disabilites: disabilites);

    return patient;
  }

  void _goToMedicalInfo(WidgetRef ref, BuildContext context) {
    ref.read(appBarVisibilityProvider.notifier).toggleVisibility();

    final patient = _setupDummyPatient(ref);
    ref.read(patientProvider.notifier).setPatient(patient);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const MedicalInfoScreen()));
  }

  void _goToUserInfo(WidgetRef ref,BuildContext context){
    ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
            final patient = _setupDummyPatient(ref);
            ref.read(patientProvider.notifier).setPatient(patient);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const UserInfoScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        CustomCard(title: "User Info", onTap: _goToUserInfo),
        const SizedBox(height: 20),
        CustomCard(title: "Medical Info", onTap: _goToMedicalInfo)
      ],
    );
  }
}

import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/disability.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/medication.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/providers/disability_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mockPatient = StateProvider<Patient>((ref) {

  User user = User(
        firstname: "Miran",
        lastname: "Miran",
        password: "*******",
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
      Disease(
          name: "Cold",
          medications: [Medication(name: "Ibuprofren", weeklyDosage: 3)]),
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
});
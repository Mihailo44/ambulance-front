import 'package:ambulance_app/generic_widgets/custom_card.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/screens/patient_profile_managment/medical_info_screen.dart';
import 'package:ambulance_app/screens/patient_profile_managment/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientProfile extends ConsumerWidget {
  const PatientProfile({super.key});

  void _goToMedicalInfo(WidgetRef ref, BuildContext context) {
    ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const MedicalInfoScreen()));
  }

  void _goToUserInfo(WidgetRef ref, BuildContext context) {
    ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const UserInfoScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        CustomCard(title: "User Info", onTap: _goToUserInfo),
        const SizedBox(height: 20),
        CustomCard(title: "Medical Info", onTap: _goToMedicalInfo),
      ],
    );
  }
}
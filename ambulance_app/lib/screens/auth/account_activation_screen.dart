import 'dart:convert';

import 'package:ambulance_app/model/account_activation_credentials.dart';
import 'package:ambulance_app/providers/service_provider.dart';
import 'package:ambulance_app/screens/patient_profile_managment/medical_info_screen.dart';
import 'package:ambulance_app/services/mobile/verification_service_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountActivationScreen extends ConsumerStatefulWidget {
  const AccountActivationScreen({required this.phoneNumber,required this.username,required this.password,super.key});

  final String phoneNumber;
  final String username;
  final String password;

  @override
  ConsumerState<AccountActivationScreen> createState() =>
      _AccountActivationScreenState();
}

class _AccountActivationScreenState extends ConsumerState<AccountActivationScreen> {

  final _activationService = VerificationService();
  final _codeController = TextEditingController();

  void _activate() async{
    final credentials = AccountActivationCredentials(phoneNumber: widget.phoneNumber,activationCode: _codeController.text);
    final nav = Navigator.of(context);
    final result = await _activationService.activateAccount(credentials);

    if(result){
      final res1 = await ref.read(authServiceProvider).login(widget.username,widget.password);
      if(res1){
        nav.push(MaterialPageRoute(builder: (ctx) => const MedicalInfoScreen()));
      }
    }else{
      nav.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Enter the verification code",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OtpTextField(
              numberOfFields: 5,
              keyboardType: TextInputType.visiblePassword,
              enabledBorderColor: Colors.black26,
              focusedBorderColor: Colors.blueAccent,
              onSubmit: (String code){
                _codeController.text = code;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _activate,
                  child: const Text("Activate"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Resend Code"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

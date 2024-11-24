<<<<<<< HEAD
import 'dart:convert';

import 'package:ambulance_app/model/account_activation_credentials.dart';
import 'package:ambulance_app/services/mobile/verification_service_mobile.dart';
=======
import 'package:ambulance_app/util/snackbar.dart';
>>>>>>> main
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class AccountActivationScreen extends StatefulWidget {
<<<<<<< HEAD
  const AccountActivationScreen({required this.phoneNumber,super.key});

  final String phoneNumber;
=======
  const AccountActivationScreen({super.key});
>>>>>>> main

  @override
  State<AccountActivationScreen> createState() =>
      _AccountActivationScreenState();
}

class _AccountActivationScreenState extends State<AccountActivationScreen> {
<<<<<<< HEAD

  final _activationService = VerificationService();
  final _codeController = TextEditingController();

  void _activate() async{
    final credentials = AccountActivationCredentials(phoneNumber: widget.phoneNumber,activationCode: _codeController.text);
    final nav = Navigator.of(context);
    final result = await _activationService.activateAccount(credentials);
    nav.pop();
  }

=======
>>>>>>> main
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
<<<<<<< HEAD
=======
              
>>>>>>> main
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OtpTextField(
              numberOfFields: 5,
              keyboardType: TextInputType.visiblePassword,
              enabledBorderColor: Colors.black26,
              focusedBorderColor: Colors.blueAccent,
<<<<<<< HEAD
              onSubmit: (String code){
                _codeController.text = code;
              },
=======
>>>>>>> main
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
<<<<<<< HEAD
                  onPressed: _activate,
=======
                  onPressed: () {
                    showSnackBar(context, "Account was successfully verified!");
                    //* authService.login()
                  },
>>>>>>> main
                  child: const Text("Activate"),
                ),
                ElevatedButton(
                  onPressed: () {},
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

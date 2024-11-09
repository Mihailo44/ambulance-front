import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class AccountActivationScreen extends StatefulWidget {
  const AccountActivationScreen({super.key});

  @override
  State<AccountActivationScreen> createState() =>
      _AccountActivationScreenState();
}

class _AccountActivationScreenState extends State<AccountActivationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  showSnackBar(context, "Account was successfully verified!");
                },
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
    );
  }
}

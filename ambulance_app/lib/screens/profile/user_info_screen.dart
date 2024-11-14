import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/screens/profile/update_user_info_screen.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({required this.patient, super.key});

  final Patient patient;

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _passwordController = TextEditingController();
  final _contactController = TextEditingController();
  final _emergencyContactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstnameController.text = widget.patient.user.firstname;
    _lastnameController.text = widget.patient.user.lastname;
    _dateOfBirthController.text = widget.patient.user.dateOfBirth.toString();
    _passwordController.text = widget.patient.user.password;
    _contactController.text = widget.patient.contactNumber;
    _emergencyContactController.text = widget.patient.closePersonContact;
  }

  @override
  void dispose() {
    super.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    _contactController.dispose();
    _emergencyContactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                context, "Firstname", _firstnameController.text),
            buildFormattedTextField(
                context, "Lastname", _lastnameController.text),
            buildFormattedTextField(context, "Date of Birth",
                _dateOfBirthController.text.substring(0, 10)),
            buildFormattedTextField(
                context, "Password", _passwordController.text),
            buildFormattedTextField(
                context, "Contact Number", _contactController.text),
            buildFormattedTextField(
                context, "Emergency Contact", _emergencyContactController.text),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) =>
                          UpdateUserInfoScreen(patient: widget.patient));
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

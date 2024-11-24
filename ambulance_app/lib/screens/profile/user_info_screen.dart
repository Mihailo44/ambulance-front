import 'package:ambulance_app/generic_widgets/error_page.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/providers/basic_user_provider.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/providers/service_provider.dart';
import 'package:ambulance_app/screens/patient_profile_managment/update_user_info_screen.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  bool _isLoading = true;
  bool _error = false;

  @override
  void initState(){
    super.initState();
    if (ref.read(patientProvider) == null) {
         _getPatient();
    } else {
      _isLoading = false;
    }
  }

 void _getPatient() async {
    var result = await ref
        .read(patientServiceProvider)
        .getByUsername(ref.read(basicUserProvider)!.username);

    result = await ref
      .read(authServiceProvider)
      .getByUsername();

    if (result) {
      setState(() {
        _isLoading = !_isLoading;
        _error = false;
      });
    } else {
      if (!context.mounted) return;
      setState(() {
        _error = true;
      });
      //Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final patient = ref.watch(patientProvider);

    Widget content = _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFormattedTextField(
                    context, "Firstname", patient!.user!.firstname),
                buildFormattedTextField(
                    context, "Lastname", patient.user!.lastname),
                buildFormattedTextField(
                    context, "Year of Birth", patient.yearOfBirth.toString()),
                buildFormattedTextField(
                    context, "Password","********"),
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
                          builder: (ctx) => UpdateUserInfoScreen(
                              patient: ref.read(patientProvider)!));
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit profile"),
                    style:
                        Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              minimumSize:
                                  const WidgetStatePropertyAll(Size(210, 62)),
                            ),
                  ),
                ),
              ],
            ),
          );

    if (_error) {
      content = const ErrorPage(error: "Error");
    }

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
                  ref
                      .read(appBarVisibilityProvider.notifier)
                      .toggleVisibility();
                }
              }),
          title: Text(
            "Profile overview",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: content
      );
  }
}
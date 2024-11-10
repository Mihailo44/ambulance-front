import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class UserInfoScreen extends ConsumerStatefulWidget {

  const UserInfoScreen({required this.patient,super.key});

  final Patient patient;

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {

  final _firstnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstnameController.text = widget.patient.user.firstname;
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
                ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
                Navigator.of(context).pop();
              }
            }),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildTextFormField(controller: _firstnameController, labelText: "Name") 
          ),
        ],
      ),
    );
  }
  
}
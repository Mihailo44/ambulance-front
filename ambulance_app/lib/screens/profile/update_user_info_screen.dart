import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/close.dart';
import 'package:ambulance_app/util/dateFormater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateUserInfoScreen extends ConsumerStatefulWidget {
  const UpdateUserInfoScreen({required this.patient,super.key});
  final Patient patient;

  @override
  ConsumerState<UpdateUserInfoScreen> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends ConsumerState<UpdateUserInfoScreen>{
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _passwordController = TextEditingController();
  final _contactController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  DateTime? _pickedDate;

   @override
  void initState() {
    super.initState();
    _firstnameController.text = widget.patient.user.firstname;
    _lastnameController.text = widget.patient.user.lastname;
    _dateOfBirthController.text =
        widget.patient.user.dateOfBirth.toString();
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

   void _openDatePicker() {
    final now = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: DateTime(2000, now.month, now.day),
      firstDate: DateTime(1940, DateTime.january, DateTime.monday),
      lastDate: DateTime(now.year, now.month, now.day),
      initialEntryMode: DatePickerEntryMode.input,
    ).then((value) {
      setState(() {
        _pickedDate = value;
      });
    });
  }

  void _saveUser(){
    ref.read(patientProvider.notifier).updateUserInfo(firstname: _firstnameController.text,lastname: _lastnameController.text,contactNumber: _contactController.text,emergencyContact: _emergencyContactController.text,password: _passwordController.text,dateOfBirth: _pickedDate);
    close(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15,15,15,MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70,),
                  buildTextFormField(labelText: "Firstname",controller:  _firstnameController),
                  buildTextFormField(labelText: "Lastname",controller:  _lastnameController),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _pickedDate == null
                              ? "Date of Birth"
                              : formatter.format(_pickedDate!),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ElevatedButton.icon(
                          label: const Text("Open"),
                          onPressed: () {
                            _openDatePicker();
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ),
                    ],
                  ),
                  buildTextFormField(labelText: "Password",controller:  _passwordController),
                  buildTextFormField(labelText: "Contact Number",controller:  _contactController),
                  buildTextFormField(labelText: "Emergency Contact",controller:  _emergencyContactController),
                  const SizedBox(height: 170,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            close(context);
                          }, 
                          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                            minimumSize: const WidgetStatePropertyAll(Size(140, 62)),
                          ),
                          child: const Text("Cancel"),
                        ),
                    const SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: _saveUser, 
                      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        minimumSize: const WidgetStatePropertyAll(Size(160, 62)),
                      ),
                      child: const Text("Save changes"),
                    ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
  
}
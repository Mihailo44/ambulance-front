import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/close.dart';
import 'package:ambulance_app/util/dateFormater.dart';
import 'package:flutter/material.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  const UpdateUserInfoScreen({required this.patient,super.key});
  final Patient patient;

  @override
  State<UpdateUserInfoScreen> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen>{
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50,),
                buildTextFormField(labelText: "Firstname",controller:  _firstnameController),
                buildTextFormField(labelText: "Lastname",controller:  _lastnameController),
                Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                ElevatedButton.icon(
                                  label: const Text("Open"),
                                  onPressed: () {
                                    _openDatePicker();
                                  },
                                  icon: const Icon(Icons.calendar_month),
                                ),
                              ],
                            ),
                buildTextFormField(labelText: "Password",controller:  _passwordController),
                buildTextFormField(labelText: "Contact Number",controller:  _contactController),
                buildTextFormField(labelText: "Emergency Contact",controller:  _emergencyContactController),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: (){
                            close(context);
                          }, 
                          icon: const Icon(Icons.cancel),
                          label: const Text("Cancel"),
                          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                            minimumSize: const WidgetStatePropertyAll(Size(180, 62)),
                          ),
                        ),
                    const SizedBox(height: 15,),
                    ElevatedButton.icon(
                      onPressed: (){
                        close(context);
                      }, 
                      icon: const Icon(Icons.edit),
                      label: const Text("Save changes"),
                      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        minimumSize: const WidgetStatePropertyAll(Size(180, 62)),
                      ),
                    ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
  
}
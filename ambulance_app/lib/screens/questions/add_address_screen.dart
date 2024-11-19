import 'package:ambulance_app/model/address.dart';
import 'package:ambulance_app/util/buildTextFormFields.dart';
import 'package:ambulance_app/util/close.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _floorController = TextEditingController();
  final _aparmentNumberController = TextEditingController();

  void _addAddress() {
    Address address = Address(city: _cityController.text, street: _streetController.text, number: _numberController.text,floor: _floorController.text,apartmentNumber: _aparmentNumberController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _floorController.dispose();
    _aparmentNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                ),
                Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildTextFormField(controller: _cityController, labelText: "City"),
                    buildTextFormField(
                        controller: _streetController, labelText: "Street"),
                    buildTextFormField(
                        controller: _numberController, labelText: "Number"),
                    buildTextFormField(
                        controller: _floorController,
                        labelText: "Floor (Optional)"),
                    buildTextFormField(
                        controller: _aparmentNumberController,
                        labelText: "Apartment (Optional)"),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed:() => close(context),
                            child: const Text("Close")),
                        ElevatedButton(
                            onPressed: _addAddress, child: const Text("Add")),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

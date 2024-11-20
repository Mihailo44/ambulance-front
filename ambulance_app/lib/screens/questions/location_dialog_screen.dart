import 'package:ambulance_app/generic_widgets/my_dialog.dart';
import 'package:ambulance_app/model/address.dart';
import 'package:ambulance_app/providers/ambulance_request_provider.dart';
import 'package:ambulance_app/providers/location_provider.dart';
import 'package:ambulance_app/screens/questions/add_address_screen.dart';
import 'package:ambulance_app/services/map_service.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationDialogScreen extends ConsumerStatefulWidget {
  const LocationDialogScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LocationDialogScreenState();
}

class _LocationDialogScreenState extends ConsumerState<LocationDialogScreen> {
  final MapService mapService = MapService();
  String _location = "";
  bool _isClicked = false;

  void _getLocation() async {
    String location = await ref.read(locationProvider.notifier).getLocation();
    setState(() {
      _location = location;
    });
  }

  void _selectGPS() {
    if (_isClicked) {
      ref.read(ambulanceRequestProvider.notifier).setAddress(null);
    } else {
      String streetAndNumber = _location.split(",")[0];
      String city = _location.split(",")[1];
      String country = _location.split(",")[2];
      Address address = Address(
          city: city,
          street: streetAndNumber.split("")[0],
          number: streetAndNumber.split("")[1],
          country: country);
      ref.read(ambulanceRequestProvider.notifier).setAddress(address);
    }
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  void _addOtherAddress() {

    ref.read(ambulanceRequestProvider.notifier).setAddress(null);

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => const AddAddressScreen());

    setState(() {
      _isClicked = false;
    });
  }

  void _sendRequest() async {
    if (ref.read(ambulanceRequestProvider).address == null) {
      showSnackBar(context, "Please select an address first");
      return;
    }

    bool? result = await showDialog<bool>(
        context: context, builder: (ctx) => const MyDialog());
    if (result != null && result == true) {
      ref.read(ambulanceRequestProvider).x();
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 249, 234),
        scrolledUnderElevation: 0,
        leading: IconButton(
            iconSize: 32,
            color: Colors.amber,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }),
      ),
      body: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Choose location",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 80,
              ),
              _location.isEmpty
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.amber,
                    )
                  : InkWell(
                      splashColor: const Color.fromARGB(255, 234, 229, 192),
                      borderRadius: BorderRadius.circular(12),
                      onTap: _selectGPS,
                      child: Container(
                        constraints: const BoxConstraints(
                            minHeight: 150, minWidth: 270, maxWidth: 270),
                        child: Card(
                          color: _isClicked
                              ? const Color.fromARGB(255, 231, 255, 231)
                              : const Color.fromARGB(255, 255, 249, 231),
                          shadowColor: _isClicked ? Colors.green : Colors.amber,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          elevation: _isClicked ? 8 : 4,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: AutoSizeText(
                              _location,
                              maxLines: 3,
                              style: _isClicked
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: const Color.fromARGB(255, 115,
                                              196, 118)) // Change text color
                                  : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                splashColor: const Color.fromARGB(255, 234, 229, 192),
                borderRadius: BorderRadius.circular(12),
                onTap: _addOtherAddress,
                child: Container(
                  constraints: const BoxConstraints(
                      minHeight: 150, minWidth: 270, maxWidth: 270),
                  child: Card(
                    color: const Color.fromARGB(255, 255, 249, 231),
                    shadowColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        "Add Different Address",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(180, 70),
                  backgroundColor: const Color.fromARGB(255, 7, 154, 180),
                  foregroundColor: Colors.white,
                ),
                onPressed: _sendRequest,
                icon: const Icon(Icons.send),
                label: const Text(
                  "Send Request",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

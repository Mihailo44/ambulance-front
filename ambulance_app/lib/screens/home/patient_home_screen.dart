import 'package:ambulance_app/navigation/routes.dart';
import 'package:ambulance_app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.end,
      children:[ 
        Expanded(child: const MapScreen()),
        const SizedBox(height: 50,),
        ElevatedButton(
        onPressed: () {
          router.go("/ambulance-request");
        },
        child: const Text("New Request"),
      ),
      ]
    );
  }
}

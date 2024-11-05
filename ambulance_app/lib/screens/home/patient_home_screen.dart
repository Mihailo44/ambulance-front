import 'package:ambulance_app/navigation/routes.dart';
import 'package:ambulance_app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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
        children: [
          Expanded(
              child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              const MapScreen(),
              Padding(
                padding:const EdgeInsets.fromLTRB(20, 0, 20, 25),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_to_home_screen_rounded),
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                              backgroundColor: const WidgetStatePropertyAll(
                                  Color.fromARGB(255, 248, 43, 70)),
                              minimumSize: const WidgetStatePropertyAll(
                                  ui.Size(150, 90)),
                              foregroundColor:
                                  const WidgetStatePropertyAll(Colors.white),
                            ),
                        onPressed: () {
                          router.push("/ambulance-request");
                        },
                        label: const Text("Send Request"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton.icon(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                              backgroundColor: const WidgetStatePropertyAll(
                                  Color.fromARGB(255, 14, 147, 14)),
                              minimumSize: const WidgetStatePropertyAll(
                                  ui.Size(150, 90)),
                              foregroundColor:
                                  const WidgetStatePropertyAll(Colors.white),
                            ),
                        onPressed: () {
                          //router.go("/ambulance-request");
                        },
                        icon: const Icon(Icons.call),
                        label: const Text("Call 911"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ]);
  }
}

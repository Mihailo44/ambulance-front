import 'package:ambulance_app/navigation/observer.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/screens/map_screen.dart';
import 'package:ambulance_app/screens/questions/trauma_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher_string.dart';

class PatientHomeScreen extends ConsumerStatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  ConsumerState<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends ConsumerState<PatientHomeScreen>{

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
          child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          const MapScreen(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(310, 0, 15, 16),
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      backgroundColor: const WidgetStatePropertyAll(
                          Color.fromARGB(255, 39, 154, 225)),
                      minimumSize:
                          const WidgetStatePropertyAll(ui.Size(73, 73)),
                      foregroundColor:
                          const WidgetStatePropertyAll(Colors.white),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      )),
                  onPressed: () {
                    ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
                    Navigator.of(context).push(MaterialPageRoute(
                      settings: const RouteSettings(name: "/patient-list"),
                      builder: (ctx) => TraumaTypeScreen(),));
                  },
                  child: const Icon(
                    Icons.add_to_home_screen_rounded,
                    size: 34,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(310, 0, 15, 22),
                child: ElevatedButton.icon(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: const WidgetStatePropertyAll(
                            Color.fromARGB(255, 14, 147, 14)),
                        minimumSize:
                            const WidgetStatePropertyAll(ui.Size(80, 80)),
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
                      ),
                  onPressed: () {
                    _makePhoneCall("tel://+381658750575");
                  },
                  label: const Icon(
                    Icons.call,
                    size: 34,
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    ]);
  }
}

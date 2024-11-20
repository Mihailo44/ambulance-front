import 'dart:async';

import 'package:ambulance_app/model/ambulance_request.dart';
import 'package:ambulance_app/providers/ambulance_request_provider.dart';
import 'package:ambulance_app/services/inactivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InactivityDialog extends ConsumerStatefulWidget {
  const InactivityDialog({required this.duration,super.key});

  final int duration;

  @override
  ConsumerState<InactivityDialog> createState() => _InactivityDialogState();
}

class _InactivityDialogState extends ConsumerState<InactivityDialog> {

  Timer? _expirationTimer;
  late int _secondsLeft;

  void _decrementTime(){
    if(_secondsLeft > 0){
    setState(() {
    _secondsLeft --;
    });
    }else{
      Navigator.of(context).pop();
      _expirationTimer?.cancel();
    }
  }

  void _sendEmergencyRequest(){
    final AmbulanceRequest request = ref.read(ambulanceRequestProvider);
    //TODO poslati zahtev
  }

  @override
  void initState() {
    super.initState();
    InactivityService().startEmergencyTimer(_sendEmergencyRequest);
    _secondsLeft = widget.duration;
    _expirationTimer = Timer.periodic(const Duration(seconds: 1),(timer){
      _decrementTime();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _expirationTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Inactive'),
      content: Text('Are you still there? $_secondsLeft'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}

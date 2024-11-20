import 'dart:async';
import 'package:flutter/material.dart';

class InactivityService {
  static final InactivityService _instance = InactivityService._internal();
  factory InactivityService() => _instance;

  InactivityService._internal();

  Timer? _inactivityTimer;
  final int _inactivityThreshold = 6000005; //* In seconds
  int _remainingTime = 20; 
  DateTime? _startTime;
  VoidCallback? onInactivity;

  Timer? _emergencyTimer;
  final int _emergencyTimerDuration = 20;
  VoidCallback? onEmergency;

  void startTracking(VoidCallback onInactivityCallback) {
    onInactivity = onInactivityCallback;
    resetTimer();
  }

  void stopTracking(){
    _inactivityTimer?.cancel();
    _emergencyTimer?.cancel();
  }

  void resetTimer() {
    print("reset");
    _inactivityTimer?.cancel();
    _emergencyTimer?.cancel();
    _remainingTime = _inactivityThreshold;
    _startNewTimer(_remainingTime);
  }

  void _startNewTimer(int duration) {
    _startTime = DateTime.now();
    _inactivityTimer = Timer(Duration(seconds: duration), () {
        onInactivity?.call();
    });
  }

  void startEmergencyTimer(VoidCallback onEmergency){
    _emergencyTimer = Timer(Duration(seconds: _emergencyTimerDuration),(){
      onEmergency.call();
    });
  }


  int get getInactivityThreshold => _inactivityThreshold;

  int get getEmergencyTimerDuration => _emergencyTimerDuration;

  int get remainingTime {
   if (_startTime != null) {
      final elapsed = DateTime.now().difference(_startTime!).inSeconds;
      return _remainingTime - elapsed;
    } else {
      return _inactivityThreshold;
    }
  }

  void dispose() {
    _inactivityTimer?.cancel();
  }
}

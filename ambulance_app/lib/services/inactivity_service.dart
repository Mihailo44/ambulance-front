import 'dart:async';
import 'package:flutter/material.dart';

class InactivityService {
  static final InactivityService _instance = InactivityService._internal();
  factory InactivityService() => _instance;

  InactivityService._internal();

  Timer? _inactivityTimer;
  final int inactivityThreshold = 30; //* In seconds
  int _remainingTime = 30; 

  Timer? _automaticRequestTimer;
  int _automaticRequestRemainingTime = 30;
  DateTime? _startTimeSecond;

  DateTime? _startTime;
  VoidCallback? onInactivity;

  void startTracking(VoidCallback onInactivityCallback) {
    onInactivity = onInactivityCallback;
    resetTimer();
  }

  void resetTimer() {
    _inactivityTimer?.cancel();
    _remainingTime = inactivityThreshold;
    _automaticRequestTimer?.cancel();
    _automaticRequestRemainingTime = inactivityThreshold;
    _startNewTimer(_remainingTime);
  }

  void _startNewTimer(int duration) {
    _startTime = DateTime.now();
    _inactivityTimer = Timer(Duration(seconds: duration), () {
        onInactivity?.call();
    });
  }

   void _startSecondTimer(int duration) {
    _startTimeSecond = DateTime.now();
    _automaticRequestTimer = Timer(Duration(seconds: duration), () {
        onInactivity?.call();
    });
  }  

  int get remainingTime {
   if (_startTime != null) {
      final elapsed = DateTime.now().difference(_startTime!).inSeconds;
      return _remainingTime - elapsed;
    } else {
      return inactivityThreshold;
    }
  }

  void dispose() {
    _inactivityTimer?.cancel();
  }
}

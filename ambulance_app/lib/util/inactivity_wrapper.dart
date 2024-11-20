import 'package:ambulance_app/providers/input_monitor_provider.dart';
import 'package:ambulance_app/services/inactivity_service.dart';
import 'package:ambulance_app/util/inactivity_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InactivityWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const InactivityWrapper({super.key, required this.child});

  @override
  ConsumerState<InactivityWrapper> createState() => _InactivityWrapperState();
}

class _InactivityWrapperState extends ConsumerState<InactivityWrapper> {
  
  @override
  void dispose() {
    InactivityService().dispose();
    super.dispose();
  }

  void _showInactivityDialog() {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (ctx) => InactivityDialog(duration: InactivityService().getEmergencyTimerDuration),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final shouldMonitor = ref.watch(userInputMonitoringProvider);
   
    if(shouldMonitor){
      InactivityService().startTracking(() {
      _showInactivityDialog();
    });
    }else{
      InactivityService().stopTracking();
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: shouldMonitor ? () => InactivityService().resetTimer() : null,
      onPanUpdate: shouldMonitor ? (_) => InactivityService().resetTimer() : null,
      onVerticalDragDown: shouldMonitor ? (_) => InactivityService().resetTimer() : null,
      child: widget.child,
    );
  }
}

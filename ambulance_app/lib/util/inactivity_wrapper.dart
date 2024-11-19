import 'package:ambulance_app/services/inactivity_service.dart';
import 'package:flutter/material.dart';

class InactivityWrapper extends StatefulWidget {
  final Widget child;

  const InactivityWrapper({super.key, required this.child});

  @override
  State<InactivityWrapper> createState() => _InactivityWrapperState();
}

class _InactivityWrapperState extends State<InactivityWrapper> {
  @override
  void initState() {
    super.initState();
    InactivityService().startTracking(() {
      _showInactivityDialog();
    });
  }

  @override
  void dispose() {
    InactivityService().dispose();
    super.dispose();
  }

  void _showInactivityDialog() {
    if (context.mounted) {
      //TODO pozvati drugi tajmer
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Inactive'),
          content: Text('Are you still there? ${InactivityService().remainingTime}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => InactivityService().resetTimer(),
      onPanUpdate: (_) => InactivityService().resetTimer(),
      child: widget.child,
    );
  }
}

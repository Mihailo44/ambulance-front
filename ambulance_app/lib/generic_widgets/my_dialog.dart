import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm'),
      content: Text(
        'Are you sure you want to proceed?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
           Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
  
}
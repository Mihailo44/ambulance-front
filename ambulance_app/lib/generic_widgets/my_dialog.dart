import 'package:ambulance_app/util/close.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({this.onYes,this.onYesParam,this.param,super.key});

  final void Function()? onYes;
  final void Function(String)? onYesParam;
  final String? param;

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
           close(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            if(onYes != null){
              onYes!();
            }else if(onYesParam != null){
              onYesParam!(param!);
            }
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
  
}
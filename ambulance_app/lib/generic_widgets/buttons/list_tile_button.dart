import 'package:flutter/material.dart';

class ListTileButton extends StatelessWidget {
  const ListTileButton({required this.onPressed,required this.labelText,required this.icon,this.backgroundColor,this.overlayColor,super.key});

  final String labelText;
  final void Function()? onPressed;
  final Icon icon;
  final Color? backgroundColor;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(labelText),
      icon: icon,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 60),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        overlayColor: overlayColor
      ),
    );
  }
  
}
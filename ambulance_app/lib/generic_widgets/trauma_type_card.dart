import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TraumaTypeCard extends StatelessWidget {
  const TraumaTypeCard({required this.label, this.onTap, super.key});

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(         
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: AutoSizeText(
                label,
                maxLines: label.toUpperCase() == "ELECTROCUTION" || label.toUpperCase() == "UNCONSCIOUSNESS" ? 1 : 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 23,
                  
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 2, 41, 108),
                ),
              ),
        ),
      ),
    );
  }
}

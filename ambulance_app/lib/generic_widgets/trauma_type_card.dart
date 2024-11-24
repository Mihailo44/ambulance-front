import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TraumaTypeCard extends StatelessWidget {
  const TraumaTypeCard({required this.label, this.onTap, super.key});

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        splashColor: const Color.fromARGB(255, 168, 246, 208),
        borderRadius: BorderRadius.circular(12),
        child: Card(
          //surfaceTintColor: Colors.green,
          color: const Color.fromARGB(255, 255, 254, 248),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              alignment: const Alignment(0, 0),
              child: AutoSizeText(
                    label,
                    maxLines: label.toUpperCase() == "ELECTROCUTION" || label.toUpperCase() == "UNCONSCIOUSNESS" ? 1 : 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 2, 41, 108),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

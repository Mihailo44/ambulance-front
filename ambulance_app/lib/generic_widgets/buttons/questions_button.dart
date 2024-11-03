import 'package:flutter/material.dart';

class QuestionsButton extends StatelessWidget {

  const QuestionsButton({required this.label,required this.fun,super.key});

  final String label;
  final Function()? fun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            //backgroundColor: const Color.fromARGB(255, 210, 227, 252),
            minimumSize:
                Size(MediaQuery.of(context).size.width * 0.25, 60),
          ),
          onPressed: fun,
          child: Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 23, 78, 166),
            ),
          ),
        );
  }
}
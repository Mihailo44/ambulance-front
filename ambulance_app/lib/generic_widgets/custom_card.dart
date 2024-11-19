import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCard extends ConsumerWidget {
  const CustomCard({required this.title,this.onTap, super.key});

  final String title;
  final void Function(WidgetRef ref,BuildContext context)? onTap;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return InkWell(
      splashColor: const Color.fromARGB(255, 234, 229, 192),
      borderRadius: BorderRadius.circular(12),
      onTap: (){
        if(onTap != null){
          onTap!(ref,context);
        }
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 150, minWidth: 250),
        child: Card(
          color: const Color.fromARGB(255, 255, 249, 231),
          shadowColor: Colors.amber,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}

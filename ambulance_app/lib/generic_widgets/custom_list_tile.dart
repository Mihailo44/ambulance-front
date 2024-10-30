import 'package:ambulance_app/main.dart';
import 'package:flutter/material.dart';

class CustomListTile<T> extends StatelessWidget {
  final T? item;
  final String title;
  final String? subtitle;
  final IconData? iconData;
  final VoidCallback onPressed;
  final Screen whoCalled;

  const CustomListTile({
      this.item,
      required this.whoCalled,
      required this.title,
      this.subtitle,
      this.iconData,
      required this.onPressed,
      super.key
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            tileColor: Colors.white,
            leading: Text( //! OVDE JE BILO title PRE
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 27,
                  ),
            ),
            subtitle: Text(
              subtitle == null ? "" : subtitle!,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
            trailing: whoCalled == Screen.victimsScreen
                ? ElevatedButton.icon(
                    onPressed: onPressed,
                    icon: const Icon(Icons.remove, size: 18),
                    label: const Text('Remove'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 50, 31),
                      foregroundColor: Colors.white,
                      overlayColor: const Color.fromARGB(255, 251, 106, 106),
                    ),
                  )
                : ElevatedButton.icon(
                    onPressed: onPressed,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
          ),
        ));
  }
}

import 'package:ambulance_app/main.dart';
import 'package:flutter/material.dart';

class CustomListTile<T> extends StatelessWidget {
  final T? item;
  final String title;
  final String? subtitle;
  final IconData? iconData;
  final VoidCallback onPressed;
  final Mode mode;

  const CustomListTile(
      {this.item,
      this.mode = Mode.display,
      required this.title,
      this.subtitle,
      this.iconData,
      required this.onPressed,
      super.key});

  Widget _buildTrailing(Mode mode) {
    switch (mode) {
      case Mode.delete:
        {
          return ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.remove, size: 18),
            label: const Text('Remove'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 50, 31),
              foregroundColor: Colors.white,
              overlayColor: const Color.fromARGB(255, 251, 106, 106),
            ),
          );
        }
      case Mode.create:
        {
          return ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        }
      default:
        {
          return IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.info_outlined, size: 28),
            style: IconButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 10, 195, 251),
              minimumSize: const Size(50, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          minTileHeight: 65,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 15.0),
          tileColor: const Color.fromARGB(255, 253, 254, 254),
          leading: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          subtitle: Text(
            subtitle == null ? "" : subtitle!,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
          ),
          trailing: mode == Mode.none ? null : _buildTrailing(mode),
          splashColor: const Color.fromARGB(255, 198, 242, 255),
          onTap: mode == Mode.display
              ? () {
                  onPressed();
                }
              : () {},
        ),
      ),
    );
  }
}

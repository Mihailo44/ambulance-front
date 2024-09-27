import 'package:flutter/material.dart';

class CustomListTile<T> extends StatelessWidget{
  final T item;
  final String title;
  final String subtitle;
  final IconData iconData;
  final VoidCallback onPressed;

  CustomListTile({
    required this.item,
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 5, // Adds shadow for depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
        ),
        child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            tileColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
          ),
            trailing: ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(Icons.add, size: 18),
              label: Text('Add'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ) 
    );
  }
}
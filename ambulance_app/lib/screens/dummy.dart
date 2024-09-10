
import 'package:flutter/material.dart';

class UserButton extends StatefulWidget{

  
  const UserButton({super.key});

  @override
  State<UserButton> createState() => _UserButtonState();

  /*@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Pretisnuo si'),
      child: Container(
        height: 60.0,
        width: 120.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(left: 30.0),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 39, 118, 183),
        ),

        child: const Center(
          child: Text('CLICK HERE'),
        ),
      ),
    );
  }*/
}

class _UserButtonState extends State<UserButton>{
   bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
         setState(() {
           _isPressed = !_isPressed;
           print(_isPressed.toString());
         });
        },
        child: Container(
          color: getColor(),
        ),
      ),
    );
  }

  Color getColor(){
    if (_isPressed){
        return Colors.teal;
    }else{
      return Colors.green;
    }
  }
}
import 'package:flutter/material.dart';

void close(BuildContext context){
  if(Navigator.of(context).canPop()){
    Navigator.of(context).pop();
  }
}
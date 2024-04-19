import 'package:flutter/material.dart';

class MyAppBar extends AppBar{
  String texto;
  MyAppBar({super.key,
    required this.texto
  }): super(title: Text(texto));
}
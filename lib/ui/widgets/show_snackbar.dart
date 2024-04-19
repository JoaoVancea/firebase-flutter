import "package:flutter/material.dart";

showSnackBar(
    {required BuildContext context,
    required String texto,
    bool isErro = true}) {
  SnackBar snackBar =
    SnackBar(
      backgroundColor: isErro ? Colors.red : Colors.green, 
      content: Text(texto),
      duration: const Duration(seconds: 4),
      showCloseIcon: true,
    );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

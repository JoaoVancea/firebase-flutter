import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigationBar(int itemSelecionado, nextStation) {
  return BottomNavigationBar(
    currentIndex: itemSelecionado,
    //Verifica em qual posição está selecionada, usando ambas as listas, a do meuniInferior e a das telas acima

    onTap: nextStation,

    unselectedItemColor: Colors.black,
    selectedItemColor: Colors.black,
    items: [
      bottomNavigationBarItem(Icons.home, 'Home'),
      bottomNavigationBarItem(Icons.person, 'Perfil'),
    ],
  );
}

BottomNavigationBarItem bottomNavigationBarItem(IconData icon, String texto) {
  return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      label: texto);
}

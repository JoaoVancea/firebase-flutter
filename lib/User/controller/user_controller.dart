import 'package:flutter/material.dart';
import 'package:login_cadastro/User/database/user_database.dart';
import 'package:login_cadastro/ui/pages/HomePage.dart';

class UserController {
  UserDataBase userDataBase = UserDataBase();

  void login(BuildContext context, String nome, String senha) {
    /*uso o iterador para percorrer a lista e verificar se existe o nome passado
  e armazeno o resultado desse iteração na variável resultado*/
    var resultado = UserDataBase.users.indexWhere((item) => item.name == nome);
    if (resultado == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Usuário ou senha inválidos'),
        ),
      );
    }

    if (UserDataBase.users[resultado].password == senha) {
      /*o 'pushAndRemoveUtil' serve para colocar o prato de cima embaixo, pq no mobile o sistema que se usa é de empilhamento de pratos
  ent, qnd eu logo, ele volta para pagina logada se tornando a base */
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Usuário ou senha inválidos'),
        ),
      );
    }
  }
}

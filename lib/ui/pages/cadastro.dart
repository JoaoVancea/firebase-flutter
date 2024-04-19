import 'package:flutter/material.dart';
import 'package:login_cadastro/User/controller/authentication_service.dart';
import 'package:login_cadastro/User/controller/user_controller.dart';
import 'package:login_cadastro/User/database/user_database.dart';
import 'package:login_cadastro/User/model/user_model.dart';
import 'package:login_cadastro/ui/pages/HomePage.dart';
import 'package:login_cadastro/ui/pages/login.dart';
import 'package:login_cadastro/ui/widgets/show_snackbar.dart';

class Cadastro extends StatelessWidget {
  Cadastro({super.key});

  UserController userController = UserController();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  final emailController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset('assets/NikoStudie.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                    hintText: 'Usuário', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: 'Email', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Senha', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: confirmarSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Confirmar senha', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 500,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (nomeController.text.isNotEmpty &&
                      senhaController.text.isNotEmpty &&
                      confirmarSenhaController.text.isNotEmpty &&
                      emailController.text.isNotEmpty) {
                    if (senhaController.text != confirmarSenhaController.text) {
                      showSnackBar(
                          context: context, texto: 'Senhas não coincidem');
                    } else {
                      _authenticationService
                          .cadastrarUsuario(
                              name: nomeController.text,
                              email: emailController.text,
                              password: senhaController.text)
                          .then((String? erro) {
                        //Voltou com erro
                        if (erro != null) {
                          showSnackBar(context: context, texto: erro);
                        } else {
                          // //Deu certo
                          showSnackBar(
                              context: context,
                              texto: 'Cadastro efetuado com sucesso!',
                              isErro: false);
                              
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (_) => Login(
                          //           newUser: UserModel(
                          //               name: nomeController.text,
                          //               email: emailController.text,
                          //               password: senhaController.text))),
                          //   (route) => false,
                          // );

                          _authenticationService.loginUsuario(email: emailController.text, password: senhaController.text);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
                        }
                      });
                    }
                  } else {
                    showSnackBar(
                        context: context, texto: 'Preencha todos os campos!');
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 103, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text('Cadastrar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

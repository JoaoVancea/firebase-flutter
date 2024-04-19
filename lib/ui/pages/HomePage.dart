import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_cadastro/Study/controller/StudyController.dart';
import 'package:login_cadastro/Study/database/Study_database.dart';
import 'package:login_cadastro/User/controller/authentication_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final valor = TextEditingController();
  final isValidade = GlobalKey<FormState>();

  StudyController studyController = StudyController();
  StudyDatabase studyDatabase = StudyDatabase();
  String novoItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {
                AuthenticationService().signOut();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/NikoStudie2.png',
                width: 230,
                height: 250,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Adicione suas Tarefas",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Form(
                    key: isValidade,
                    child: TextFormField(
                      controller: valor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Não pode estar vazio';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.black,
                        hintText: 'Digite um item',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 35,
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isValidade.currentState!.validate()) {
                          setState(() {
                            studyController.addStudy(valor);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 103, 1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Text('Adicionar Item',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: StudyDatabase.studies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange, // Cor da borda laranja
                          width: 1, // Largura da borda
                        ),
                        borderRadius:
                            BorderRadius.circular(10), // Raio da borda
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: StudyDatabase.checkboxStates[index],
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      StudyDatabase.checkboxStates[index] =
                                          newValue!;
                                    });
                                  },
                                ),
                                Text(
                                  StudyDatabase.studies[index].topic,
                                  style: StudyDatabase.checkboxStates[index]
                                      ? const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough)
                                      : null,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Edição de item'),
                                      content: TextFormField(
                                        initialValue:
                                            StudyDatabase.studies[index].topic,
                                        decoration: const InputDecoration(
                                          labelText: 'Novo item',
                                        ),
                                        onChanged: (value) {
                                          novoItem = value;
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              studyController.editStudy(
                                                  index, novoItem);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Salvar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outlined),
                              onPressed: () {
                                setState(() {
                                  studyController.removeStudy(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

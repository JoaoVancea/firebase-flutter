import 'package:flutter/material.dart';
import 'package:login_cadastro/Study/database/Study_database.dart';
import 'package:login_cadastro/Study/model/StudyModel.dart';

 // Importa o modelo de objeto

class StudyController {
  StudyDatabase studyDatabase = StudyDatabase();
  // Funções de manipulação dos estudos

  void addStudy(TextEditingController topicController) {
    StudyDatabase.studies.add(StudyModel(topic: topicController.text, isDone: false));
    StudyDatabase.checkboxStates.add(false);
    topicController.clear();
  }

  void removeStudy(int index) {
    StudyDatabase.studies.removeAt(index);
  }

  void editStudy(int index, String newTopic) {
    StudyDatabase.studies[index].topic = newTopic;
    Navigator.pop;
  }
}
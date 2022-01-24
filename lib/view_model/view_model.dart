import 'package:flutter/material.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/model/task_repository.dart';
import 'package:todo_pwa/view/style.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});

  ScreenSize screenSize = ScreenSize.SMALL;

  void addNewTask(
    String title,
    String detail,
    DateTime limitDateTime,
    bool isImportant,
  ) {
    repository.addNewTask(
      title,
      detail,
      limitDateTime,
      isImportant,
    );
    print("tasks: $baseTaskList");
  }
}

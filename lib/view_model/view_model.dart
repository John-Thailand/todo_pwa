import 'package:flutter/material.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/model/task_repository.dart';
import 'package:todo_pwa/view/style.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});

  ScreenSize screenSize = ScreenSize.SMALL;

  List<Task> selectedTaskList = [];
  bool isSorted = false;
  bool isFinishedTasksIncluded = false;

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
    getTaskList();
  }

  void getTaskList() {
    selectedTaskList = repository.getTaskList(
      isSorted,
      isFinishedTasksIncluded,
    );
  }

  void sort(bool isSort) {
    isSorted = isSort;
    getTaskList();
  }

  void finishTask(Task selectedTask, isFinished) {
    repository.finishTask(selectedTask, isFinished);
    getTaskList();
  }

  void deleteTask(Task selectedTask) {
    repository.deleteTask(selectedTask);
    getTaskList();
  }

  undo() {
    repository.undo();
    getTaskList();
  }

  changeFinishStatus(bool isIncluded) {
    isFinishedTasksIncluded = isIncluded;
    getTaskList();
  }
}

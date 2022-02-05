import 'package:flutter/material.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/model/task_repository.dart';
import 'package:todo_pwa/view/style.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});

  // スクリーンサイズ
  ScreenSize screenSize = ScreenSize.small;

  // 選択されたタスクのリスト
  List<Task> selectedTaskList = [];
  // ソートされているか
  bool isSorted = false;
  // 完了したタスクも含むのか
  bool isFinishedTasksIncluded = false;

  Task? currentTask;
  Task? taskBeforeChange;

  // 新しいタスクを追加
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

  // タスクリストの取得
  void getTaskList() {
    selectedTaskList = repository.getTaskList(
      isSorted,
      isFinishedTasksIncluded,
    );
  }

  // ソート
  void sort(bool isSort) {
    isSorted = isSort;
    getTaskList();
  }

  // タスクを完了する
  void finishTask(Task selectedTask, isFinished) {
    taskBeforeChange = selectedTask;
    repository.finishTask(selectedTask, isFinished);
    getTaskList();
  }

  // タスクを削除する
  void deleteTask(Task selectedTask) {
    taskBeforeChange = selectedTask;
    repository.deleteTask(selectedTask);
    getTaskList();
  }

  // UNDO処理
  undo() {
    currentTask = taskBeforeChange;
    repository.undo();
    getTaskList();
  }

  // 完了ステータスに変更
  changeFinishStatus(bool isIncluded) {
    isFinishedTasksIncluded = isIncluded;
    getTaskList();
  }

  // 現在のタスクの情報をセット
  void setCurrentTask(Task? selectedTask) {
    currentTask = selectedTask;
    notifyListeners();
  }

  // タスクのアップデート
  void updateTask(Task taskUpdated) {
    repository.updateTaskList(taskUpdated);
    getTaskList();
  }
}

import 'package:todo_pwa/data/task.dart';

class TaskRepository {
  List<Task> baseTaskListBeforeChange = [];

  // タスクの追加
  void addNewTask(
    String title,
    String detail,
    DateTime limitDateTime,
    bool isImportant,
  ) {
    final nextId = getNextId();
    print("nextId: $nextId");

    final newTask = Task(
      id: nextId,
      title: title,
      detail: detail,
      limitDateTime: limitDateTime,
      isImportant: isImportant,
      isFinished: false,
    );
    baseTaskList.add(newTask);
  }

  // 次のIdを取得する
  int getNextId() {
    final maxId = baseTaskList
        .reduce((currentTodo, nextTodo) =>
            currentTodo.id > nextTodo.id ? currentTodo : nextTodo)
        .id;
    return maxId + 1;
  }

  // タスクリストの取得
  List<Task> getTaskList(
    bool isSorted,
    bool isFinishedTasksIncluded,
  ) {
    var returnList = <Task>[];
    returnList = getBaseTaskList(isFinishedTasksIncluded);

    if (isSorted) {
      return sortByImportant(returnList);
    }

    return returnList;
  }

  // タスクのソート機能を含めたもの
  List<Task> getBaseTaskList(bool isFinishedTasksIncluded) {
    baseTaskList.sort((a, b) => a.limitDateTime.compareTo(b.limitDateTime));

    if (isFinishedTasksIncluded) {
      return baseTaskList;
    } else {
      return baseTaskList.where((task) => task.isFinished == false).toList();
    }
  }

  // 重要なタスクを優先的に表示するためのソート
  List<Task> sortByImportant(List<Task> taskList) {
    taskList.sort((a, b) {
      final isImportantA = a.isImportant;
      final isImportantB = b.isImportant;
      final compare = a.limitDateTime.compareTo(b.limitDateTime);

      if (isImportantA && (!isImportantB || compare < 0)) {
        return -1;
      } else if (!isImportantB && compare < 0) {
        return -1;
      } else {
        return 1;
      }
    });
    return taskList;
  }

  // タスクを完了する処理
  void finishTask(Task selectedTask, isFinished) {
    // baseTaskListBeforeChange = baseTaskList;
    baseTaskListBeforeChange = copyBaseTaskList();
    final updateTask = selectedTask.copyWith(isFinished: isFinished);
    updateTaskList(updateTask);
  }

  // タスクの削除
  void deleteTask(Task selectedTask) {
    baseTaskListBeforeChange = copyBaseTaskList();
    final index = searchIndex(selectedTask);
    baseTaskList.removeAt(index);
  }

  // タスクの更新
  void updateTaskList(Task updateTask) {
    final index = searchIndex(updateTask);
    baseTaskList[index] = updateTask;
  }

  // タスクのインデックスを検索
  int searchIndex(Task selectedTask) {
    return baseTaskList.indexWhere((task) => task.id == selectedTask.id);
  }

  // UNDO処理の実装
  void undo() {
    baseTaskList = baseTaskListBeforeChange;
  }

  List<Task> copyBaseTaskList() {
    var returnList = <Task>[];

    baseTaskList.forEach((task) {
      returnList.add(task);
    });

    return returnList;
  }
}

import 'package:todo_pwa/data/task.dart';

class TaskRepository {
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

  int getNextId() {
    final maxId = baseTaskList
        .reduce((currentTodo, nextTodo) =>
            currentTodo.id > nextTodo.id ? currentTodo : nextTodo)
        .id;
    return maxId + 1;
  }
}

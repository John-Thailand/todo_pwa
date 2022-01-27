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

  List<Task> getBaseTaskList(bool isFinishedTasksIncluded) {
    baseTaskList.sort((a, b) => a.limitDateTime.compareTo(b.limitDateTime));

    if (isFinishedTasksIncluded) {
      return baseTaskList;
    } else {
      return baseTaskList.where((task) => task.isFinished == false).toList();
    }
  }

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

  void finishTask(Task selectedTask, isFinished) {
    final updateTask = selectedTask.copyWith(isFinished: isFinished);
    updateTaskList(updateTask);
  }

  void updateTaskList(Task updateTask) {
    final index = searchIndex(updateTask);
    baseTaskList[index] = updateTask;
  }

  int searchIndex(Task selectedTask) {
    return baseTaskList.indexWhere((task) => task.id == selectedTask.id);
  }
}

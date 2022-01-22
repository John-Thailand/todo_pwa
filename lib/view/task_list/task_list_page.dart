import 'package:flutter/material.dart';
import 'package:todo_pwa/view/style.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageColor.taskListBgColor,
    );
  }
}

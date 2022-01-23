import 'package:flutter/material.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/view/common/task_content_part.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        centerTitle: true,
        title: Text(StringR.addNewTask),
        actions: [
          IconButton(
            onPressed: () => _onDoneAddNewTask(context),
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: TaskContentPart(),
    );
  }

  _onDoneAddNewTask(BuildContext context) {}
}

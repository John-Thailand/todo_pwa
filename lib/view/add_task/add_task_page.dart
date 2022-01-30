import 'package:flutter/material.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/view/common/show_snack_bar.dart';
import 'package:todo_pwa/view/common/task_content_part.dart';
import 'package:todo_pwa/view_model/view_model.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  final taskContentKey = GlobalKey<TaskContentPartState>();

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
      body: TaskContentPart(
        isEditMode: false,
        key: taskContentKey,
      ),
    );
  }

  _onDoneAddNewTask(BuildContext context) {
    final taskContentState = taskContentKey.currentState;
    if (taskContentState == null) return;
    if (taskContentState.formKey.currentState!.validate()) {
      final viewModel = context.read<ViewModel>();
      viewModel.addNewTask(
        taskContentState.titleController.text,
        taskContentState.detailController.text,
        taskContentState.limitDateTime,
        taskContentState.isImportant,
      );
      Navigator.pop(context);

      showSnackBar(
        context: context,
        contentText: StringR.addTaskCompleted,
        isSnackBarActionNeeded: false,
      );
    }
  }
}

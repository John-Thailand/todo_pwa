import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/view/common/show_snack_bar.dart';
import 'package:todo_pwa/view/common/task_content_part.dart';
import 'package:todo_pwa/view/style.dart';
import 'package:todo_pwa/view_model/view_model.dart';
import 'package:tuple/tuple.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);

  final taskContentPartKey = GlobalKey<TaskContentPartState>();

  @override
  Widget build(BuildContext context) {
    return Selector<ViewModel, Tuple2<Task?, ScreenSize>>(
        selector: (context, vm) => Tuple2(vm.currentTask, vm.screenSize),
        builder: (context, data, child) {
          final selectedTask = data.item1;
          final screenSize = data.item2;

          if (selectedTask != null && screenSize != ScreenSize.SMALL) {
            _updateDetailInfo(selectedTask);
          }

          return FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Scaffold(
              backgroundColor: CustomColors.detailBgColor,
              appBar: AppBar(
                leading: (selectedTask != null)
                    ? IconButton(
                        onPressed: () {
                          _clearCurrentTask(context);
                          if (screenSize == ScreenSize.SMALL) {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(Icons.close),
                      )
                    : null,
                title: Text(StringR.taskDetail),
                centerTitle: true,
                actions: (selectedTask != null)
                    ? [
                        FocusTraversalOrder(
                          order: NumericFocusOrder(3.0),
                          child: IconButton(
                            onPressed: () => _updateTask(context, selectedTask),
                            icon: Icon(Icons.done),
                          ),
                        ),
                        FocusTraversalOrder(
                          order: NumericFocusOrder(4.0),
                          child: IconButton(
                            onPressed: null,
                            // _deleteTask(context, selectedTask),
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ]
                    : null,
              ),
              body: (selectedTask != null)
                  ? FocusTraversalOrder(
                      order: const NumericFocusOrder(1.0),
                      child: TaskContentPart(
                        key: taskContentPartKey,
                        isEditMode: true,
                        selectedTask: selectedTask,
                      ),
                    )
                  : null,
              floatingActionButton: (selectedTask != null)
                  ? FocusTraversalOrder(
                      order: const NumericFocusOrder(2.0),
                      child: FloatingActionButton.extended(
                        onPressed: () => _finishTask(context, selectedTask),
                        elevation: 0.0,
                        backgroundColor: CustomColors.detailPageFabBgColor,
                        label: Text(
                          (!selectedTask.isFinished)
                              ? StringR.complete
                              : StringR.inComplete,
                          style: TextStyles.completeButtonTextStyle.copyWith(
                            color: CustomColors.detailFabTextColor(context),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          );
        });
  }

  void _clearCurrentTask(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    viewModel.setCurrentTask(null);
  }

  void _updateDetailInfo(Task selectedTask) {
    final taskContentPartState = taskContentPartKey.currentState;
    if (taskContentPartState == null) return;
    taskContentPartState.taskEditing = selectedTask;
    taskContentPartState.setDetailData();
  }

  _updateTask(BuildContext context, Task selectedTask) {
    final taskContentPartState = taskContentPartKey.currentState;
    if (taskContentPartState == null) return;
    if (taskContentPartState.formKey.currentState!.validate()) {
      final viewModel = context.read<ViewModel>();
      final taskUpdated = selectedTask.copyWith(
        title: taskContentPartState.titleController.text,
        detail: taskContentPartState.detailController.text,
        limitDateTime: taskContentPartState.limitDateTime,
        isImportant: taskContentPartState.isImportant,
      );
      viewModel.updateTask(taskUpdated);

      showSnackBar(
        context: context,
        contentText: StringR.editTaskCompleted,
        isSnackBarActionNeeded: false,
      );

      endEditTask(context, isEdit: true);
    }
  }

  _deleteTask(BuildContext context, Task selectedTask) {
    final viewModel = context.read<ViewModel>();
    viewModel.deleteTask(selectedTask);
    showSnackBar(
      context: context,
      contentText: StringR.deleteTaskCompleted,
      isSnackBarActionNeeded: true,
      onUndone: () => viewModel.undo(),
    );
    endEditTask(context, isEdit: false);
  }

  _finishTask(BuildContext context, Task selectedTask) {
    final viewModel = context.read<ViewModel>();
    final isFinished = !selectedTask.isFinished;
    viewModel.finishTask(selectedTask, isFinished);
    showSnackBar(
      context: context,
      contentText: (isFinished)
          ? StringR.finishTaskCompleted
          : StringR.unFinishTaskCompleted,
      isSnackBarActionNeeded: true,
      onUndone: () => viewModel.undo(),
    );
    endEditTask(context, isEdit: false);
  }

  void endEditTask(BuildContext context, {required bool isEdit}) {
    final viewModel = context.read<ViewModel>();
    final screenSize = viewModel.screenSize;

    if (screenSize == ScreenSize.SMALL) {
      Navigator.pop(context);
    } else {
      if (!isEdit) viewModel.setCurrentTask(null);
    }
  }
}

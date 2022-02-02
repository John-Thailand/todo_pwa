import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/view/common/show_add_new_task.dart';
import 'package:todo_pwa/view/common/show_snack_bar.dart';
import 'package:todo_pwa/view/detail/detail_screen.dart';
import 'package:todo_pwa/view/side_menu/side_menu_page.dart';
import 'package:todo_pwa/view/style.dart';
import 'package:todo_pwa/view/task_list/task_list_tile.dart';
import 'package:todo_pwa/view_model/view_model.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future(() {
      final viewModel = context.read<ViewModel>();
      viewModel.getTaskList();
    });

    return Consumer<ViewModel>(builder: (context, vm, child) {
      final screenSize = vm.screenSize;
      final selectedTaskList = vm.selectedTaskList;
      final isSorted = vm.isSorted;

      return Scaffold(
        backgroundColor: CustomColors.taskListBgColor,
        appBar: AppBar(
          title: Text(StringR.taskList),
          centerTitle: true,
          actions: [
            (isSorted)
                ? IconButton(
                    onPressed: () => _sort(context, false),
                    icon: const Icon(Icons.undo),
                  )
                : IconButton(
                    onPressed: () => _sort(context, true),
                    icon: const Icon(Icons.sort),
                  ),
          ],
        ),
        floatingActionButton: (screenSize == ScreenSize.LARGE)
            ? null
            : FloatingActionButton(
                onPressed: () => _addNewTask(context),
                child: const Icon(Icons.add),
              ),
        drawer: (screenSize != ScreenSize.LARGE)
            ? Drawer(child: SideMenuPage())
            : null,
        body: ListView.builder(
          itemCount: selectedTaskList.length,
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            final task = selectedTaskList[index];

            final now = DateTime.now();
            final limit = task.limitDateTime;

            return Card(
              color: (now.compareTo(limit) > 0)
                  ? CustomColors.periodOverTaskColor
                  : CustomColors.taskCardBgColor(context),
              child: (DeviceInfo.isWebOrDesktop)
                  ? _createTaskListTile(context, task)
                  : Slidable(
                      key: ValueKey<int>(task.id),
                      child: _createTaskListTile(context, task),
                      endActionPane: ActionPane(
                        dismissible: DismissiblePane(
                          onDismissed: () => _deleteTask(context, task),
                        ),
                        motion: const ScrollMotion(),
                        extentRatio: 0.65,
                        children: [
                          SlidableAction(
                            label: StringR.edit,
                            icon: Icons.edit,
                            backgroundColor:
                                CustomColors.slideActionColorLight(context),
                            onPressed: (context) =>
                                _showTaskDetail(context, task),
                          ),
                          SlidableAction(
                            label: StringR.delete,
                            icon: Icons.delete,
                            backgroundColor:
                                CustomColors.slideActionColorDark(context),
                            onPressed: (context) => _deleteTask(context, task),
                          ),
                          SlidableAction(
                            label: StringR.close,
                            icon: Icons.close,
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      );
    });
  }

  _createTaskListTile(BuildContext context, Task task) {
    return TaskListTilePart(
      task: task,
      onFinishChanged: (isFinished) => _finishTask(context, isFinished, task),
      onDelete: () => _deleteTask(context, task),
      onEdit: () => _showTaskDetail(context, task),
    );
  }

  _sort(BuildContext context, bool isSort) {
    final viewModel = context.read<ViewModel>();
    viewModel.sort(isSort);
  }

  _addNewTask(BuildContext context) {
    showAddNewTask(context);
  }

  _finishTask(BuildContext context, isFinished, Task selectedTask) {
    if (isFinished == null) return;
    final viewModel = context.read<ViewModel>();
    viewModel.finishTask(selectedTask, isFinished);

    showSnackBar(
      context: context,
      contentText: StringR.finishTaskCompleted,
      isSnackBarActionNeeded: true,
      onUndone: () => viewModel.undo(),
    );

    viewModel.setCurrentTask(null);
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

    viewModel.setCurrentTask(null);
  }

  _showTaskDetail(BuildContext context, Task selectedTask) {
    final viewModel = context.read<ViewModel>();
    final screenSize = viewModel.screenSize;
    viewModel.setCurrentTask(selectedTask);

    if (screenSize == ScreenSize.SMALL) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(),
        ),
      );
    }
  }
}

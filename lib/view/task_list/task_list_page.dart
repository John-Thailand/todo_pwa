import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/view/common/show_add_new_task.dart';
import 'package:todo_pwa/view/side_menu/side_menu_page.dart';
import 'package:todo_pwa/view/style.dart';
import 'package:todo_pwa/view_model/view_model.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewModel>(builder: (context, vm, child) {
      final screenSize = vm.screenSize;

      return Scaffold(
        backgroundColor: PageColor.taskListBgColor,
        appBar: AppBar(
          title: Text(StringR.taskList),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => _sort(context),
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
      );
    });
  }

  _sort(BuildContext context) {}

  _addNewTask(BuildContext context) {
    showAddNewTask(context);
  }
}

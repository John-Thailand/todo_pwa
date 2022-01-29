import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/view/common/task_content_part.dart';
import 'package:todo_pwa/view/style.dart';
import 'package:todo_pwa/view_model/view_model.dart';
import 'package:tuple/tuple.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ViewModel, Tuple2<Task?, ScreenSize>>(
        selector: (context, vm) => Tuple2(vm.currentTask, vm.screenSize),
        builder: (context, data, child) {
          final selectedTask = data.item1;
          final screenSize = data.item2;

          return Scaffold(
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
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.done),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.delete),
                      ),
                    ]
                  : null,
            ),
            body: TaskContentPart(),
          );
        });
  }

  void _clearCurrentTask(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    viewModel.setCurrentTask(null);
  }
}

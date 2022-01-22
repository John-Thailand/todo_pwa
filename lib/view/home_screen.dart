import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_pwa/view/side_menu/side_menu_page.dart';
import 'package:todo_pwa/view/style.dart';
import 'package:todo_pwa/view/task_list/task_list_page.dart';
import 'package:todo_pwa/view_model/view_model.dart';

import 'detail/detail_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= BreakPointWidth.midToLarge) {
          viewModel.screenSize = ScreenSize.LARGE;
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: SideMenuPage(),
              ),
              Expanded(
                flex: 4,
                child: TaskListPage(),
              ),
              Expanded(
                flex: 6,
                child: DetailPage(),
              ),
            ],
          );
        } else if (constraints.maxWidth >= BreakPointWidth.smallToMid) {
          viewModel.screenSize = ScreenSize.MID;
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: TaskListPage(),
              ),
              Expanded(
                flex: 2,
                child: DetailPage(),
              ),
            ],
          );
        } else {
          viewModel.screenSize = ScreenSize.SMALL;
          return TaskListPage();
        }
      },
    );
  }
}

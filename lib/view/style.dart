import 'package:flutter/material.dart';

class PageColor {
  static const sideMenuBgColor = Color(0xFF1b1b1b);
  static const taskListBgColor = Color(0xFF212121);
  static const detailBgColor = Color(0xFF424242);
}

class WidgetColors {
  static const timeOverChipBgColor = Colors.red;
}

class BreakPointWidth {
  static const double smallToMid = 600;
  static const double midToLarge = 1240;
}

enum ScreenSize {
  SMALL,
  MID,
  LARGE,
}

class WidgetSize {
  static const double addTaskDialogWidth = 500.0;
  static const double addTaskDialogHeight = 500.0;
}

class TextStyles {
  static const newTaskTitleTextStyle = TextStyle(fontSize: 18.0);
  static const newTaskItemTextStyle = TextStyle(fontSize: 16.0);
  static const newTaskDetailTextStyle = TextStyle(fontSize: 14.0);
}

class VerticalSpacer {
  static const taskContent = SizedBox(height: 8.0);
}

class HorizontalSpacer {
  static const taskContent = SizedBox(width: 24.0);
}

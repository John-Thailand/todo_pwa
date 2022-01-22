import 'package:flutter/material.dart';
import 'package:todo_pwa/view/style.dart';

class SideMenuPage extends StatelessWidget {
  const SideMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageColor.sideMenuBgColor,
    );
  }
}

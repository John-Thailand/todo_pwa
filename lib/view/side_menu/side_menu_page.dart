import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/view/style.dart';
import 'package:todo_pwa/view_model/view_model.dart';

class SideMenuPage extends StatelessWidget {
  const SideMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageColor.sideMenuBgColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                FlutterLogo(
                  size: 100.0,
                ),
                Text(StringR.appTitle),
              ],
            ),
          ),
          ListTile(
            title: Text(StringR.addNewTask),
            onTap: () {
              final viewModel = context.read<ViewModel>();
              final screenSize = viewModel.screenSize;
              if (screenSize != ScreenSize.LARGE) Navigator.pop(context);
              _addNewTask(context);
            },
          ),
          SwitchListTile(
            title: Text(StringR.isFinishedTaskIncluded),
            value: false,
            onChanged: null,
          ),
          ListTile(
              title: Text(StringR.showLicense),
              onTap: () {
                // ライセンス表記方法：1
                showAboutDialog(
                  context: context,
                  applicationIcon: FlutterLogo(),
                  applicationName: StringR.appTitle,
                  applicationLegalese: "\u{a9} 2022 Starrybase LLC",
                  children: [
                    Text("他の情報やWidgetが出せる"),
                  ],
                );

                // ライセンス表記方法：3
                // showLicensePage(
                //   context: context,
                //   applicationName: StringR.appTitle,
                //   applicationIcon: FlutterLogo(),
                //   applicationLegalese: "\u{a9} 2022 Starrybase LLC",
                //   applicationVersion: "1.0.0",
                // );
              }),
          // ライセンス表記方法：2
          // AboutListTile(
          //   icon: Icon(Icons.info_outline),
          //   applicationIcon: FlutterLogo(),
          //   applicationName: StringR.appTitle,
          //   applicationLegalese: "\u{a9} 2022 Starrybase LLC",
          //   aboutBoxChildren: [
          //     Text("他の情報やWidgetが出せる"),
          //   ],
          // ),
        ],
      ),
    );
  }

  _addNewTask(BuildContext context) {}
}

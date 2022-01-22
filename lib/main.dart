import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_pwa/di/providers.dart';
import 'package:todo_pwa/view/home_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: globalProviders,
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

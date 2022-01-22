import 'package:flutter/material.dart';
import 'package:todo_pwa/model/task_repository.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});
}

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_model.dart';

class AddTodoController extends ChangeNotifier {
  SharedPreferences prefs;

  final String _keyTask = "all_task";
  final String _keyDate = "all_date";
  final String _keyTime = "all_time";

  List<String> _allTask = [];
  List<String> _allDate = [];
  List<String> _allTime = [];

  List<TodoModel> allTodos = [];

  AddTodoController({required this.prefs});

  List<TodoModel> get getAllTodos {
    _allTask = prefs.getStringList(_keyTask) ?? [];
    _allDate = prefs.getStringList(_keyDate) ?? [];
    _allTime = prefs.getStringList(_keyTime) ?? [];

    allTodos = List.generate(
      _allTask.length,
      (index) => TodoModel(
        task: _allTask[index],
        date: _allDate[index],
        time: _allTime[index],
      ),
    );

    return allTodos;
  }

  void addTodo({
    required String task,
    required String date,
    required String time,
  }) {
    _allTask = prefs.getStringList(_keyTask) ?? [];
    _allDate = prefs.getStringList(_keyDate) ?? [];
    _allTime = prefs.getStringList(_keyTime) ?? [];

    _allTask.add(task);
    _allDate.add(date);
    _allTime.add(time);

    prefs.setStringList(_keyTask, _allTask);
    prefs.setStringList(_keyDate, _allDate);
    prefs.setStringList(_keyTime, _allTime);

    notifyListeners();
  }

  void removeTodo(TodoModel allTodo, {required int index}) {
    _allTask = prefs.getStringList(_keyTask) ?? [];
    _allDate = prefs.getStringList(_keyDate) ?? [];
    _allTime = prefs.getStringList(_keyTime) ?? [];

    _allTask.removeAt(index);
    _allDate.removeAt(index);
    _allTime.removeAt(index);

    prefs.setStringList(_keyTask, _allTask);
    prefs.setStringList(_keyDate, _allDate);
    prefs.setStringList(_keyTime, _allTime);

    notifyListeners();
  }
}

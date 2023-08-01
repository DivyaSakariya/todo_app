import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/add_todo_controller.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/models/todo_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO List"),
        centerTitle: true,
      ),
      body: Consumer<AddTodoController>(builder: (context, provider, _) {
        return ListView.builder(
          itemCount: provider.getAllTodos.length,
          itemBuilder: (context, index) {
            final todo = provider.getAllTodos[index];
            return Card(
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    provider.removeTodo(provider.getAllTodos[index],
                        index: index);
                  },
                  icon: const Icon(Icons.delete),
                ),
                title: Text(todo.task),
                subtitle: Text(todo.date),
                trailing: Text(todo.time),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                Consumer<HomeController>(builder: (context, pro, _) {
              return AlertDialog(
                title: const Text("Add TODO"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: pro.taskController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "TODO",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          pro.showMyDate(context);
                        },
                        icon: const Icon(Icons.date_range_outlined),
                      ),
                      Text((pro.date != "") ? pro.date : "Pick Date"),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          pro.showMyTime(context);
                        },
                        icon: const Icon(Icons.watch_later_outlined),
                      ),
                      Text((pro.time != "") ? pro.time : "Pick Time"),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final todo = TodoModel(
                          task: pro.taskController.text,
                          date: pro.date,
                          time: pro.time);

                      Provider.of<AddTodoController>(context, listen: false)
                          .addTodo(
                        task: todo.task,
                        date: todo.date,
                        time: todo.time,
                      );

                      pro.taskController.clear();
                      pro.date = "";
                      pro.time = "";
                      Navigator.of(context).pop();
                    },
                    child: const Text("Done"),
                  ),
                ],
              );
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

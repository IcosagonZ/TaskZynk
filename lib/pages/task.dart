import 'package:flutter/material.dart';

// UI libraries
import '../components/cards/task.dart';

// Data libraries
import '../data/models/task.dart';


class TaskPage extends StatefulWidget
{
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
{
  List<TaskData> task_list = [
    TaskData(1, null, "Implement SQLite Table", "Implement SQLite database to store tasks and stuff", "In Progress", 0, 1, 0, 0, [], [], DateTime.now(), null),
    TaskData(1, null, "Add dark mode", "Add option to change themes", "In Progress", 0, 1, 0, 0, [], [], DateTime.now(), null),
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Tasks"),
      ),
      body: ListView
      (
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Column
            (
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(task_list.length, (index){
                return TaskCard(
                  data: task_list[index],
                  editable: false,
                );
              }),
            ),
          )
        ]
      ),
    );
  }
}

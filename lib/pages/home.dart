import 'package:flutter/material.dart';

// Pages
import 'settings.dart';
import 'kanban.dart';
import 'task.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Home"),
      ),
      body: ListView
      (
        padding: EdgeInsets.all(16),
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              child: ListTile(
                leading: Icon(Icons.task_alt),
                title: Text("Tasks"),
                subtitle: Text("View overview of all tasks arranged linearly"),
                contentPadding: EdgeInsets.all(16),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const TaskPage();
                },
                ));
              }
            ),
          ),
          SizedBox(height: 16),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              child: ListTile(
                leading: Icon(Icons.view_kanban),
                title: Text("Kanban"),
                subtitle: Text("View overview of all tasks arranged in a Kanban board"),
                contentPadding: EdgeInsets.all(16),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const KanbanPage();
                },
                ));
              }
            ),
          ),
          SizedBox(height: 16),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                subtitle: Text("Modify settings"),
                contentPadding: EdgeInsets.all(16),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const SettingsPage();
                },
                ));
              }
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

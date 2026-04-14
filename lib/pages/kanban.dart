import 'package:flutter/material.dart';

class KanbanPage extends StatefulWidget
{
  const KanbanPage({super.key});


  @override
  State<KanbanPage> createState() => _KanbanPageState();
}

class _KanbanPageState extends State<KanbanPage>
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Kanban"),
      ),
     body: Center
     (
       child: Text("wohoo")
     ),
    );
  }
}

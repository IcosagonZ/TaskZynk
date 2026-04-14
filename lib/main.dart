import 'package:flutter/material.dart';

// Pages
import 'pages/home.dart';
import 'pages/task.dart';

void main()
{
  runApp(const TaskZynkApp());
}

class TaskZynkApp extends StatelessWidget
{
  const TaskZynkApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: 'TaskZynk',
      theme: ThemeData.dark(),
      home: const TaskPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

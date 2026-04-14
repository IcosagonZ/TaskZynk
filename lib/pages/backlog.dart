import 'package:flutter/material.dart';

class BacklogPage extends StatefulWidget
{
  const BacklogPage({super.key});


  @override
  State<BacklogPage> createState() => _BacklogPageState();
}

class _BacklogPageState extends State<BacklogPage>
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Backlog"),
      ),
     body: Center
     (
       child: Column
       (
        mainAxisAlignment: .center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Text("boo")
                    ],
                  )
                )
              ],
            ),
          )
        ],
       ),
     ),
    );
  }
}

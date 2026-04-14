import 'package:flutter/material.dart';

// UI libraries
import '../components/cards/task.dart';

// Data libraries
import '../data/models/task.dart';

class KanbanPage extends StatefulWidget
{
  const KanbanPage({super.key});


  @override
  State<KanbanPage> createState() => _KanbanPageState();
}

class _KanbanPageState extends State<KanbanPage>
{
  // Data variables
  List<TaskData> taskList = [
    TaskData(1, null, "Implement SQLite Table", "Implement SQLite database to store tasks and stuff", "In Progress", 0, 1, 0, 0, [], [], DateTime.now(), null),
    TaskData(2, null, "Add dark mode", "Add option to change themes", "Backlog", 0, 1, 0, 0, [], [], DateTime.now(), null),
    TaskData(3, null, "Add theme changing", "Add option to change themes", "Wishlist", 0, 1, 0, 0, [], [], DateTime.now(), null),
    TaskData(3, null, "Add basic home screen", "Add homescreenpage", "Done", 0, 1, 0, 0, [], [], DateTime.now(), null),
    TaskData(4, null, "Initialize repo", "Setup github page", "Done", 0, 1, 0, 0, [], [], DateTime.now(), null),
  ];

  Map<String,List<TaskData>> taskMap = {};
  List<String> taskCategories = []; // Usually Backlog, Ready, In Progress, In Review, Done

  // Widget variables
  int gridColumns = 4;

  void taskMapFromList()
  {
    Map<String,List<TaskData>> taskMapNew = {};
    List<String> taskCategoriesNew = [];

    for(var task in taskList)
    {
      if(!taskCategoriesNew.contains(task.status))
      {
        taskCategoriesNew.add(task.status);
        taskMapNew.addEntries(
        {
          task.status:[task]
        }.entries
        );
      }
      else
      {
        taskMapNew.update(task.status, (list){
          list.add(task);
          return list;
        });
      }
    }

    setState(()
    {
      taskCategories = taskCategoriesNew;
      taskMap = taskMapNew;
    });
  }

  @override
  void initState()
  {
    taskMapFromList();
    //print(taskMap);

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Kanban"),
        actions: [
          SegmentedButton<int>(
            segments: [
              ButtonSegment<int>(
                value: 2,
                icon: Icon(Icons.two_k)
              ),
              ButtonSegment<int>(
                value: 4,
                icon: Icon(Icons.four_k)
              ),
            ],
            selected: <int>{gridColumns},
            onSelectionChanged: (Set<int> newGridColumns){
              setState(() {
                gridColumns = newGridColumns.first;
              });
            },
          ),
          SizedBox(width: 16)
        ]
      ),
      body: Stack
      (
        children: [
          Visibility(
            visible: taskMap.isEmpty,
            child: Center(
              child: Text("No tasks available")
            )
          ),
          Visibility(
            visible: taskMap.isNotEmpty,
            child: LayoutBuilder(
              builder: (context, constraints){

                final cellWidth = constraints.maxWidth / gridColumns;
                final cellHeight = constraints.maxHeight / 1;

                final aspectRatio = cellWidth/cellHeight;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridColumns,
                    childAspectRatio: aspectRatio,
                  ),

                  itemCount: taskCategories.length,
                  itemBuilder: (context, index){
                    final category = taskCategories[index];
                    final taskListMap = taskMap[category];
                    List<TaskData> taskList = [];

                    if(taskListMap!=null)
                    {
                      taskList = taskListMap;
                    }

                    return Card.outlined(
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(16),
                        child: Column(
                          children: [
                            Text(category),
                            SizedBox(height: 16),
                            Expanded(
                              child: ListView(
                                children: [
                                  Column(
                                    children: List.generate(taskList.length, (index){
                                      return TaskCard(
                                        data: taskList[index],
                                        editable: false,
                                        showStatus: false,
                                        showCheck: false,
                                        showEdit: false,
                                      );
                                    }),
                                  )
                                ],
                              )
                            )
                          ],
                        )
                      )
                    );
                  },
                );
              },
            )
          )
        ]
      ),
    );
  }
}

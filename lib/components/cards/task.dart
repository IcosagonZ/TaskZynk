import 'package:flutter/material.dart';

// Data libraries
import '../../data/models/task.dart';

// Data dictionaries for resolvers
Map<String, MaterialColor> progressMap = {
  "Backlog" : Colors.red,
  "Ready" : Colors.green,
  "In Progress" : Colors.blue,
  "Done" : Colors.purple,
};

Map<int, List> priorityMap = {
  0 : ["High", Colors.red],
  1 : ["Medium", Colors.yellow],
  2 : ["Low", Colors.green],
};

const Map<int, List> sizeMap = {
  0 : ["Small", Colors.red],
  1 : ["Medium", Colors.yellow],
  2 : ["Large", Colors.green],
};


class TaskCard extends StatefulWidget
{
  //const TaskCard({super.key});
  // External data
  final TaskData data;
  final bool editable;

  bool? showStatus;
  bool? showPriority;
  bool? showSize;
  bool? showEdit;
  bool? showCheck;

  TaskCard(
    {
      Key? key,
      required this.data,
      required this.editable,
      this.showStatus,
      this.showPriority,
      this.showSize,
      this.showEdit,
      this.showCheck,
    }
  ):super(key:key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard>
{
  //final text_theme = Theme.of(context).textTheme;
  //final style_titlesmall = text_theme.titleSmall;

  // Controllers
  late TextEditingController titleController;
  late TextEditingController subtitleController;

  late String stateProgress;

  final InputDecoration textfieldDecoration = InputDecoration(
    isDense: true,
    border: InputBorder.none
  );

  // Chip generator
  List<Widget> getChips()
  {
    List<Widget> chipList = [];

    // Progress chip
    if(widget.showStatus==true || widget.showStatus==null)
    {
      chipList.add(
        MenuAnchor(
          builder:(context, controller, child) {
            return ActionChip(
              label: Text(stateProgress),
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              labelStyle: TextStyle(
                fontSize: 12
              ),
              onPressed: (){
                if(controller.isOpen){
                  controller.close();
                }
                else{
                  controller.open();
                }
              },
            );
          },
          menuChildren: progressMap.keys.map((String key){
            return MenuItemButton(
              onPressed: (){
                setState(()
                {
                  stateProgress = key;
                });
              },
              child: Text(key)
            );
          }).toList(),
        )
      );
    }

    // Priority chip
    if(widget.showPriority==true || widget.showPriority==null)
    {
      final priorityMapResult = priorityMap[widget.data.priority];
      if(priorityMapResult!=null)
      {
        chipList.add(
          Tooltip(
            message: "Priority",
            child: Chip(
              label: Text(priorityMapResult[0]),
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              labelStyle: TextStyle(
                fontSize: 12
              ),
            ),
          )
        );
      }
    }

    // Size chip
    if(widget.showSize==true || widget.showSize==null)
    {
      final sizeMapResult = sizeMap[widget.data.size];
      if(sizeMapResult!=null)
      {
        chipList.add(
          Tooltip(
            message: "Size",
            child: Chip(
              label: Text(sizeMapResult[0]),
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              labelStyle: TextStyle(
                fontSize: 12
              ),
            ),
          )
        );
      }
    }

    return chipList;
  }

  @override
  void initState()
  {
    stateProgress = widget.data.status;
    subtitleController = TextEditingController(text: widget.data.description);
    titleController = TextEditingController(text: widget.data.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        child: Padding(
          padding: EdgeInsetsGeometry.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ExpansionTile(
                title: TextField(
                  controller: titleController,
                  //style: style_titlesmall,
                  decoration: textfieldDecoration,
                  readOnly: !widget.editable,
                ),

                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                childrenPadding: EdgeInsets.all(16),

                shape: Border(),
                dense: true,

                children: [
                  TextField(
                    controller: subtitleController,
                    //style: style_titlesmall,
                    decoration: textfieldDecoration,
                    readOnly: !widget.editable,
                  )
                ],
              ),

              SizedBox(height: 8),

              Row(
                children: [
                  SizedBox(width: 16),
                  // Chips
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...getChips(),
                      ],
                    ),
                  ),
                  // Action icons
                  Visibility(
                    visible: widget.showEdit==true || widget.showEdit==null,
                    child: IconButton.outlined(
                      icon: Icon(Icons.edit),
                      tooltip: "Edit",
                      iconSize: 16,
                      onPressed: (){
                        print("Edit pressed");
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  Visibility(
                    visible: (widget.showCheck==true || widget.showCheck==null) && (widget.showEdit==true || widget.showEdit==null),
                    child: SizedBox(width: 8),
                  ),
                  Visibility(
                    visible: widget.showCheck==true || widget.showCheck==null,
                    child: IconButton.outlined(
                      icon: Icon(Icons.check),
                      tooltip: "Task done",
                      iconSize: 16,
                      onPressed: (){
                        print("Check pressed");
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  SizedBox(width: 16)
                ],
              ),

              SizedBox(height: 16),
            ],
          )
        ),
        onTap: (){
          print("Card pressed");
        }
      )
    );
  }
}

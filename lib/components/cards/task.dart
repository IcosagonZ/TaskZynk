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
  // Controllers
  late TextEditingController titleController;
  late TextEditingController subtitleController;

  late String stateProgress;
  late int statePriority;
  late int stateSize;

  bool isChipMenuOpen = false;
  bool isTaskDone = false;

  final InputDecoration textfieldDecoration = InputDecoration(
    isDense: true,
    border: InputBorder.none
  );

  // Chip generator
  List<Widget> getChips(TextStyle? labelStyle)
  {
    List<Widget> chipList = [];

    // Progress chip
    if(widget.showStatus==true || widget.showStatus==null)
    {
      chipList.add(
        MenuAnchor(
          onOpen: (){
            setState(() {
              isChipMenuOpen = true;
            });
          },
          onClose: (){
            setState(() {
              isChipMenuOpen = false;
            });
          },
          builder:(context, controller, child) {
            return ActionChip(
              label: Text(stateProgress, style: labelStyle),
              tooltip: "Progress",
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
              onPressed: ()
              {
                setState(()
                {
                  stateProgress = key;
                });

                updateWidget();
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
      final priorityMapResult = priorityMap[statePriority];
      if(priorityMapResult!=null)
      {
        chipList.add(
          MenuAnchor(
            onOpen: (){
              setState(() {
                isChipMenuOpen = true;
              });
            },
            onClose: (){
              setState(() {
                isChipMenuOpen = false;
              });
            },
            builder:(context, controller, child) {
              return ActionChip(
                label: Text(priorityMapResult[0], style: labelStyle),
                tooltip: "Priority",
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
            menuChildren: priorityMap.entries.map((entry){
              return MenuItemButton(
                onPressed: (){
                  setState(()
                  {
                    statePriority = entry.key;
                  });
                },
                child: Text(entry.value[0])
              );
            }).toList(),
          )
        );
      }
    }

    // Size chip
    if(widget.showSize==true || widget.showSize==null)
    {
      final sizeMapResult = sizeMap[stateSize];
      if(sizeMapResult!=null)
      {
        chipList.add(
          MenuAnchor(
            onOpen: ()
            {
              setState(() {
                isChipMenuOpen = true;
              });
            },
            onClose: ()
            {
              setState(() {
                isChipMenuOpen = false;
              });
            },
            builder:(context, controller, child) {
              return ActionChip(
                label: Text(sizeMapResult[0], style: labelStyle),
                tooltip: "Priority",
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
            menuChildren: sizeMap.entries.map((entry){
              return MenuItemButton(
                onPressed: ()
                {
                  setState(()
                  {
                    stateSize = entry.key;
                  });
                },
                child: Text(entry.value[0])
              );
            }).toList(),
          )
        );
      }
    }

    return chipList;
  }

  // Run when change in data occurs
  void updateWidget()
  {
    setState(()
    {
      if(stateProgress=="Done")
      {
        isTaskDone = true;
      }
      else
      {
        isTaskDone = false;
      }
    });
  }

  @override
  void initState()
  {
    stateProgress = widget.data.status;
    statePriority = widget.data.priority;
    stateSize = widget.data.size;

    subtitleController = TextEditingController(text: widget.data.description);
    titleController = TextEditingController(text: widget.data.title);

    updateWidget();

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final styleTitleSmall = textTheme.titleSmall;
    final styleLabelSmall = textTheme.labelSmall;
    final styleLabelBody = textTheme.bodyMedium;

    TextStyle? styleTaskTitle = styleLabelSmall;

    if(isTaskDone)
    {
      if(styleTitleSmall!=null)
      {
        styleTaskTitle = styleTitleSmall.copyWith(decoration: TextDecoration.lineThrough);
      }
    }
    else
    {
      styleTaskTitle = styleTitleSmall;
    }

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        // Fix for focus bug when opening chip dropdown
        hoverColor: isChipMenuOpen ? Colors.transparent : null,
        splashColor: isChipMenuOpen ? Colors.transparent : null,
        highlightColor: isChipMenuOpen ? Colors.transparent : null,
        focusColor: isChipMenuOpen ? Colors.transparent : null,

        child: Padding(
          padding: EdgeInsetsGeometry.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ExpansionTile(
                title: TextField(
                  controller: titleController,
                  style: styleTaskTitle,
                  decoration: textfieldDecoration,
                  readOnly: !widget.editable,
                ),

                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                childrenPadding: EdgeInsets.all(16),

                shape: Border(),
                dense: true,

                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1), width: 2),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextField(
                      controller: subtitleController,
                      style: styleLabelBody,
                      decoration: textfieldDecoration,
                      readOnly: !widget.editable,
                      maxLines: null,
                    )
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
                        ...getChips(styleLabelSmall),
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
                        setState(() {
                          isTaskDone = true;
                          stateProgress = "Done";
                        });
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

import 'package:flutter/material.dart';

// Data libraries
import '../../data/models/task.dart';

// Data dictionaries for resolvers
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

class TaskCard extends StatelessWidget
{
  // External data
  final TaskData data;
  final bool editable;

  const TaskCard(
    {
      Key? key,
      required this.data,
      required this.editable,
    }
  ):super(key:key);

  @override
  Widget build(BuildContext context)
  {
    final text_theme = Theme.of(context).textTheme;
    final style_titlesmall = text_theme.titleSmall;

    // Controllers
    TextEditingController titleController = TextEditingController(text: data.title);
    TextEditingController subtitleController = TextEditingController(text: data.description);

    const InputDecoration textfieldDecoration = InputDecoration(
      isDense: true,
      border: InputBorder.none
    );

    // Chip generator
    List<Widget> getChips()
    {
      List<Widget> chipList = [];

      // Progress chip
      chipList.add(
        Tooltip(
          message: "Status",
          child: Chip(
            label: Text(data.status),
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            labelStyle: TextStyle(
              fontSize: 12
            ),
          ),
        )
      );

      // Priority chip
      final priorityMapResult = priorityMap[data.priority];
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

      // Size chip
      final sizeMapResult = sizeMap[data.size];
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

      return chipList;
    }

    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ExpansionTile(
              title: TextField(
                controller: titleController,
                style: style_titlesmall,
                decoration: textfieldDecoration,
                readOnly: !editable,
              ),

              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              childrenPadding: EdgeInsets.all(16),

              shape: Border(),
              dense: true,

              children: [
                TextField(
                  controller: subtitleController,
                  style: style_titlesmall,
                  decoration: textfieldDecoration,
                  readOnly: !editable,
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
                IconButton.outlined(
                  icon: Icon(Icons.edit),
                  tooltip: "Edit",
                  iconSize: 16,
                  onPressed: (){
                    print("Edit pressed");
                  },
                  visualDensity: VisualDensity.compact,
                ),
                SizedBox(width: 8),
                IconButton.outlined(
                  icon: Icon(Icons.check),
                  tooltip: "Task done",
                  iconSize: 16,
                  onPressed: (){
                    print("Check pressed");
                  },
                  visualDensity: VisualDensity.compact,
                ),
                SizedBox(width: 16)
              ],
            ),

            SizedBox(height: 16),
          ],
        )
      )
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/util/function.dart';
import 'package:todo_pwa/view/style.dart';

class TaskListTilePart extends StatelessWidget {
  final Task task;
  final ValueChanged onFinishChanged;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskListTilePart({
    Key? key,
    required this.task,
    required this.onFinishChanged,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio(
        value: true,
        groupValue: task.isFinished,
        onChanged: (value) => onFinishChanged(value),
      ),
      onTap: onEdit,
      onLongPress: onDelete,
      title: Row(
        children: [
          (task.isImportant)
              ? Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    color: Colors.black,
                    child: Text(
                      StringR.important,
                      style: TextStyles.listTileChipTextStyle,
                    ),
                  ),
                )
              // ? Padding(
              //     padding: const EdgeInsets.all(4.0),
              //     child: Chip(
              //       label: Text(StringR.important),
              //       backgroundColor: Colors.black,
              //     ),
              //   )
              : Container(),
          Expanded(
            child: AutoSizeText(
              task.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: AutoSizeText(
        convertDateTimeToString(task.limitDateTime),
      ),
    );
  }
}

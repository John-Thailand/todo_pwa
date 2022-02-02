import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/util/function.dart';
import 'package:todo_pwa/view/style.dart';

class TaskListTilePart extends StatefulWidget {
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
  State<TaskListTilePart> createState() => _TaskListTilePartState();
}

class _TaskListTilePartState extends State<TaskListTilePart> {
  bool isDisplayPopupMenu = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        if (DeviceInfo.isWebOrDesktop) {
          setState(() {
            isDisplayPopupMenu = true;
          });
        }
      },
      onExit: (_) {
        if (DeviceInfo.isWebOrDesktop) {
          setState(() {
            isDisplayPopupMenu = false;
          });
        }
      },
      child: ListTile(
        leading: Radio(
          value: true,
          groupValue: widget.task.isFinished,
          onChanged: (value) => widget.onFinishChanged(value),
        ),
        onTap: widget.onEdit,
        onLongPress: widget.onDelete,
        title: Row(
          children: [
            (widget.task.isImportant)
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
                widget.task.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: AutoSizeText(
          convertDateTimeToString(widget.task.limitDateTime),
        ),
        trailing: (!DeviceInfo.isWebOrDesktop)
            ? null
            : PopupMenuButton(
                tooltip: StringR.showMenu,
                icon: (isDisplayPopupMenu)
                    ? const Icon(Icons.more_vert)
                    : Container(),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<TaskListTileMenu>(
                      child: Text(StringR.edit),
                      value: TaskListTileMenu.EDIT,
                    ),
                    PopupMenuItem<TaskListTileMenu>(
                      child: Text(StringR.delete),
                      value: TaskListTileMenu.DELETE,
                    ),
                  ];
                },
                onSelected: (selectedMenu) {
                  if (selectedMenu == TaskListTileMenu.EDIT) {
                    widget.onEdit();
                  } else {
                    widget.onDelete();
                  }
                }),
      ),
    );
  }
}

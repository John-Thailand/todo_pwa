import 'package:flutter/material.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/util/function.dart';
import 'package:todo_pwa/view/style.dart';

class TaskContentPart extends StatefulWidget {
  const TaskContentPart({Key? key}) : super(key: key);

  @override
  State<TaskContentPart> createState() => _TaskContentPartState();
}

class _TaskContentPartState extends State<TaskContentPart> {
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  bool isImportant = false;
  DateTime limitDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            maxLines: 1,
            controller: titleController,
            style: TextStyles.newTaskTitleTextStyle,
            decoration: InputDecoration(
              icon: Icon(Icons.title),
              hintText: StringR.title,
              border: OutlineInputBorder(),
            ),
          ),
          VerticalSpacer.taskContent,
          Row(
            children: [
              HorizontalSpacer.taskContent,
              Checkbox(
                value: isImportant,
                onChanged: (value) {
                  setState(() {
                    isImportant = value!;
                  });
                },
              ),
              Text(
                StringR.important,
                style: TextStyles.newTaskItemTextStyle,
              ),
            ],
          ),
          VerticalSpacer.taskContent,
          Row(
            children: [
              HorizontalSpacer.taskContent,
              IconButton(
                onPressed: () => _setLimitDate(),
                icon: Icon(Icons.calendar_today),
              ),
              Text(
                convertDateTimeToString(limitDateTime),
                style: TextStyles.newTaskItemTextStyle,
              ),
              HorizontalSpacer.taskContent,
              (DateTime.now().compareTo(limitDateTime) > 0)
                  ? Chip(
                      label: Text(StringR.timeOver),
                      backgroundColor: WidgetColors.timeOverChipBgColor,
                    )
                  : Container(),
            ],
          ),
          VerticalSpacer.taskContent,
          TextField(
            maxLines: 10,
            controller: detailController,
            style: TextStyles.newTaskDetailTextStyle,
            decoration: InputDecoration(
              icon: Icon(Icons.description),
              hintText: StringR.detail,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  _setLimitDate() async {
    limitDateTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 36500)),
          locale: Locale("ja"),
        ) ??
        DateTime.now();
    setState(() {});
  }
}

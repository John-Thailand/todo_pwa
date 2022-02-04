import 'package:flutter/material.dart';
import 'package:todo_pwa/data/task.dart';
import 'package:todo_pwa/util/constants.dart';
import 'package:todo_pwa/util/function.dart';
import 'package:todo_pwa/view/style.dart';

class TaskContentPart extends StatefulWidget {
  final Task? selectedTask;
  final bool isEditMode;

  const TaskContentPart({
    Key? key,
    this.selectedTask,
    required this.isEditMode,
  }) : super(key: key);

  @override
  State<TaskContentPart> createState() => TaskContentPartState();
}

class TaskContentPartState extends State<TaskContentPart> {
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  bool isImportant = false;
  DateTime limitDateTime = DateTime.now();

  final formKey = GlobalKey<FormState>();

  Task? taskEditing;

  @override
  void initState() {
    if (widget.isEditMode && widget.selectedTask != null) {
      taskEditing = widget.selectedTask;
      setDetailData();
    }
    super.initState();
  }

  void setDetailData() {
    titleController.text = taskEditing!.title;
    detailController.text = taskEditing!.detail;
    isImportant = taskEditing!.isImportant;
    limitDateTime = taskEditing!.limitDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: FocusTraversalGroup(
            policy: WidgetOrderTraversalPolicy(),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return StringR.pleaseEnterTitle;
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  autofocus: true,
                  maxLines: 1,
                  controller: titleController,
                  style: TextStyles.newTaskTitleTextStyle,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.title),
                    hintText: StringR.title,
                    border: const OutlineInputBorder(),
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
                      icon: const Icon(Icons.calendar_today),
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
                    icon: const Icon(Icons.description),
                    hintText: StringR.detail,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setLimitDate() async {
    limitDateTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 36500)),
          locale: const Locale("ja"),
        ) ??
        DateTime.now();
    setState(() {});
  }
}

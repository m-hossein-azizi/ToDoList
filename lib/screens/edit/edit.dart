import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/data/repo/repository.dart';
import 'package:todolist/main.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskEntity task;

  EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.task.name);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: themeData.colorScheme.onSurface,
          title: const Text("Edit Task")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.task.name = _controller.text;
          widget.task.priority = widget.task.priority;
          final repository =
              Provider.of<Repository<TaskEntity>>(context, listen: false);
          repository.createOrupdate(widget.task);

          Navigator.of(context).pop();
        },
        label: const Row(
          children: [
            Text('Save Changes'),
            Icon(
              CupertinoIcons.check_mark,
              size: 18,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 1,
                    child: PriorityCheckBox(
                      onTap: () {
                        setState(() {
                          widget.task.priority = Priority.high;
                        });
                      },
                      lable: 'High',
                      color: highPriority,
                      isSelected: widget.task.priority == Priority.high,
                    )),
                const SizedBox(width: 8),
                Flexible(
                    flex: 1,
                    child: PriorityCheckBox(
                      onTap: () {
                        setState(() {
                          widget.task.priority = Priority.normal;
                        });
                      },
                      lable: 'Normal',
                      color: normalPriority,
                      isSelected: widget.task.priority == Priority.normal,
                    )),
                const SizedBox(width: 8),
                Flexible(
                    flex: 1,
                    child: PriorityCheckBox(
                      onTap: () {
                        setState(() {
                          widget.task.priority = Priority.low;
                        });
                      },
                      lable: 'Low',
                      color: lowpriority,
                      isSelected: widget.task.priority == Priority.low,
                    ))
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  label: Text(
                'Add Task For Today ...',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(fontSizeFactor: 1.4),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityCheckBox extends StatelessWidget {
  const PriorityCheckBox(
      {super.key,
      required this.lable,
      required this.color,
      required this.isSelected,
      required this.onTap});
  final String lable;
  final Color color;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 2,
            color: secondryTextColor.withOpacity(0.2),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(lable),
            ),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _CheckBoxShape(
                  value: isSelected,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckBoxShape extends StatelessWidget {
  const _CheckBoxShape({super.key, required this.value, required this.color});
  final bool value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      width: 16,
      height: 16,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
      child: value
          ? Icon(
              size: 12,
              CupertinoIcons.check_mark,
              color: themeData.colorScheme.onPrimary,
            )
          : null,
    );
  }
}

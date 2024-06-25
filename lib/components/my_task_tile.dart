import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyTaskTile extends StatelessWidget {
  final String text;
  final bool isDone;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editTask;
  final void Function(BuildContext)? deleteTask;

  const MyTaskTile({
    super.key,
    required this.text,
    required this.isDone,
    required this.onChanged,
    required this.editTask,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // edit option
            SlidableAction(
              onPressed: editTask,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(8),
            ),

            // delete option
            SlidableAction(
              onPressed: deleteTask,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              // toggle completion status
              onChanged!(!isDone);
            }
          },
          // habit tile
          child: Container(
            decoration: BoxDecoration(
              color: isDone
                  ? Colors.yellow
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: ListTile(
              // text
              title: Text(
                text,
                style: TextStyle(
                  color: isDone
                      ? Colors.black
                      : Theme.of(context).colorScheme.inversePrimary,
                  decoration:
                      isDone ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),

              // checkbox
              leading: Checkbox(
                activeColor: Colors.black,
                value: isDone,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

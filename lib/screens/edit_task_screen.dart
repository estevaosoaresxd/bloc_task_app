import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;

  const EditTaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Edit Task',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('title'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: true,
              controller: descriptionController,
              decoration: const InputDecoration(
                label: Text('description'),
                border: OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
              onSubmitted: (e) {
                var newTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  id: task.id,
                  isDeleted: task.isFavorite,
                  isDone: false,
                  date: DateTime.now().toIso8601String(),
                );

                context.read<TasksBloc>().add(EditTask(
                      newTask: newTask,
                    ));

                context.read<TasksBloc>().add(GetAllTask());

                Navigator.pop(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      var newTask = Task(
                        title: titleController.text,
                        id: task.id,
                        isDeleted: task.isFavorite,
                        isDone: false,
                        description: descriptionController.text,
                        date: DateTime.now().toIso8601String(),
                      );

                      context.read<TasksBloc>().add(
                            EditTask(
                              newTask: newTask,
                            ),
                          );
                      context.read<TasksBloc>().add(GetAllTask());

                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/screens/edit_task_screen.dart';
import 'package:flutter_tasks_app/widgets/popup_menu.dart';
import 'package:intl/intl.dart';
import '../blocs/bloc_exports.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDelete(BuildContext context, Task task) {
    task.isDeleted!
        ? {
            context.read<TasksBloc>().add(
                  DeleteTask(
                    task: task,
                  ),
                ),
            context.read<TasksBloc>().add(
                  GetAllTask(),
                )
          }
        : {
            context.read<TasksBloc>().add(
                  RemoveTask(
                    task: task,
                  ),
                ),
            context.read<TasksBloc>().add(
                  GetAllTask(),
                )
          };
  }

  Future<void> _editTask(BuildContext context) async {
    Navigator.pop(context);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (c) => SingleChildScrollView(
        child: EditTaskScreen(task: task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<TasksBloc>().add(
                          MarkFavoriteOrUnfavoriteTask(
                            task: task,
                          ),
                        );
                    context.read<TasksBloc>().add(GetAllTask());
                  },
                  child: Icon(
                    task.isFavorite == true
                        ? Icons.star
                        : Icons.star_outline_outlined,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy hh:mm:ss').format(
                          DateTime.parse(task.date),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                onChanged: task.isDeleted! == false
                    ? (e) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                        context.read<TasksBloc>().add(GetAllTask());
                      }
                    : null,
                value: task.isDone,
              ),
              PopupMenu(
                task: task,
                onTapDelete: () => _removeOrDelete(context, task),
                onTapFavorite: () {
                  context.read<TasksBloc>().add(
                        MarkFavoriteOrUnfavoriteTask(
                          task: task,
                        ),
                      );
                  context.read<TasksBloc>().add(GetAllTask());
                },
                onTapEdit: () async => _editTask(context),
                onTapRestore: () {
                  context.read<TasksBloc>().add(
                        RestoreTask(
                          task: task,
                        ),
                      );
                  context.read<TasksBloc>().add(
                        GetAllTask(),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

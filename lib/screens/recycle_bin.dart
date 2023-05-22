import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/screens/drawer_menu.dart';
import 'package:flutter_tasks_app/widgets/tasks_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);

  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (c) => [
                  PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.delete_forever),
                        label: const Text('Delete all tasks'),
                      ),
                      onTap: () {
                        context.read<TasksBloc>().add(
                              const DeleteAllTasks(),
                            );
                        context.read<TasksBloc>().add(
                              GetAllTask(),
                            );
                      })
                ],
              )
            ],
          ),
          drawer: const DrawerMenu(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Tasks Bin: ${state.removedTasks.length}',
                  ),
                ),
              ),
              TasksList(taskList: state.removedTasks)
            ],
          ),
        );
      },
    );
  }
}

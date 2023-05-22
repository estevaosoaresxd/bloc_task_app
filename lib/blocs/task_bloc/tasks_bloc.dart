import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/repository/firestore_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<GetAllTask>(_onGetAllTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.createTask(task: event.task);

    // final state = this.state;

    // emit(
    //   TasksState(
    //     pendingTasks: List.from(state.pendingTasks)..add(event.task),
    //     removedTasks: state.removedTasks,
    //     completedTasks: state.completedTasks,
    //     favoriteTasks: state.favoriteTasks,
    //   ),
    // );
  }

  void _onGetAllTask(GetAllTask event, Emitter<TasksState> emit) async {
    List<Task> pendingTasks = [];
    List<Task> completedTasks = [];
    List<Task> favoriteTasks = [];
    List<Task> removedTasks = [];

    await FirestoreRepository.getTask().then(
      (value) {
        for (var task in value) {
          if (task.isDeleted == true) {
            removedTasks.add(task);
          } else {
            if (task.isFavorite == true) {
              favoriteTasks.add(task);
            }

            if (task.isDone == true) {
              completedTasks.add(task);
            } else {
              pendingTasks.add(task);
            }
          }
        }
      },
    );

    // final state = this.state;

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        removedTasks: removedTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
      ),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    Task task = event.task.copyWith(isDone: !event.task.isDone!);

    await FirestoreRepository.updateTask(task: task);

    // List<Task> pendingTasks = state.pendingTasks;
    // List<Task> completedTasks = state.completedTasks;
    // List<Task> favoriteTasks = state.favoriteTasks;

    // if (task.isDone == false) {
    //   if (task.isFavorite == false) {
    //     pendingTasks = List.from(pendingTasks)..remove(task);
    //     completedTasks.insert(
    //       0,
    //       task.copyWith(isDone: true),
    //     );
    //   } else {
    //     var taskIndex = favoriteTasks.indexOf(task);
    //     pendingTasks = List.from(pendingTasks)..remove(task);
    //     completedTasks.insert(
    //       0,
    //       task.copyWith(isDone: true),
    //     );
    //     favoriteTasks = List.from(favoriteTasks)
    //       ..remove(task)
    //       ..insert(
    //         taskIndex,
    //         task.copyWith(isDone: true),
    //       );
    //   }
    // } else {
    //   if (task.isFavorite == false) {
    //     completedTasks = List.from(completedTasks)..remove(task);
    //     pendingTasks = List.from(pendingTasks)
    //       ..insert(
    //         0,
    //         task.copyWith(isDone: false),
    //       );
    //   } else {
    //     var taskIndex = favoriteTasks.indexOf(task);
    //     completedTasks = List.from(completedTasks)..remove(task);
    //     pendingTasks = List.from(pendingTasks)
    //       ..insert(
    //         0,
    //         task.copyWith(isDone: false),
    //       );
    //     favoriteTasks = List.from(favoriteTasks)
    //       ..remove(task)
    //       ..insert(
    //         taskIndex,
    //         task.copyWith(isDone: false),
    //       );
    //   }
    // }

    // emit(
    //   TasksState(
    //     pendingTasks: pendingTasks,
    //     completedTasks: completedTasks,
    //     removedTasks: state.removedTasks,
    //     favoriteTasks: state.favoriteTasks,
    //   ),
    // );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.deleteTask(task: event.task);
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) async {
    // final state = this.state;
    final task = event.task.copyWith(isDeleted: true);

    await FirestoreRepository.updateTask(task: task);

    // emit(
    //   TasksState(
    //     pendingTasks: List.from(state.pendingTasks)..remove(task),
    //     completedTasks: List.from(state.completedTasks)..remove(task),
    //     favoriteTasks: List.from(state.favoriteTasks)..remove(task),
    //     removedTasks: List.from(
    //       state.removedTasks,
    //     )..add(
    //         event.task.copyWith(isDeleted: true),
    //       ),
    //   ),
    // );
  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) async {
    await FirestoreRepository.onDeleteAllTask(tasks: state.removedTasks);

    // emit(
    //   TasksState(
    //     removedTasks: List.from(state.removedTasks)..clear(),
    //     pendingTasks: state.pendingTasks,
    //     completedTasks: state.completedTasks,
    //     favoriteTasks: state.favoriteTasks,
    //   ),
    // );
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) async {
    final task = event.task.copyWith(
      isDeleted: false,
      isDone: false,
      isFavorite: false,
      date: DateTime.now().toIso8601String(),
    );

    await FirestoreRepository.updateTask(task: task);
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.updateTask(
      task: event.task.copyWith(
        isFavorite: !event.task.isFavorite!,
      ),
    );
    // List<Task> pendingTasks = state.pendingTasks;
    // List<Task> completedTasks = state.completedTasks;
    // List<Task> favoriteTasks = state.favoriteTasks;
    // if (event.task.isDone == false) {
    //   if (event.task.isFavorite == false) {
    //     var taskIndex = pendingTasks.indexOf(event.task);
    //     pendingTasks = List.from(pendingTasks)
    //       ..remove(event.task)
    //       ..insert(taskIndex, event.task.copyWith(isFavorite: true));
    //     favoriteTasks = List.from(favoriteTasks)
    //       ..insert(0, event.task.copyWith(isFavorite: true));
    //     // favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
    //   } else {
    //     var taskIndex = pendingTasks.indexOf(event.task);
    //     pendingTasks = List.from(pendingTasks)
    //       ..remove(event.task)
    //       ..insert(taskIndex, event.task.copyWith(isFavorite: false));
    //     favoriteTasks.remove(event.task);
    //   }
    // } else {
    //   if (event.task.isFavorite == false) {
    //     var taskIndex = completedTasks.indexOf(event.task);
    //     completedTasks = List.from(completedTasks)
    //       ..remove(event.task)
    //       ..insert(taskIndex, event.task.copyWith(isFavorite: true));
    //     favoriteTasks = List.from(favoriteTasks)
    //       ..insert(0, event.task.copyWith(isFavorite: true));
    //   } else {
    //     var taskIndex = completedTasks.indexOf(event.task);
    //     completedTasks = List.from(completedTasks)
    //       ..remove(event.task)
    //       ..insert(taskIndex, event.task.copyWith(isFavorite: false));
    //     favoriteTasks.remove(event.task);
    //   }
    // }
    // emit(TasksState(
    //   pendingTasks: pendingTasks,
    //   completedTasks: completedTasks,
    //   favoriteTasks: favoriteTasks,
    //   removedTasks: state.removedTasks,
    // ));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.updateTask(task: event.newTask);

    // List<Task> favouriteTasks = state.favoriteTasks;
    // if (event.oldTask.isFavorite == true) {
    //   favouriteTasks
    //     ..remove(event.oldTask)
    //     ..insert(0, event.newTask);
    // }
    // emit(
    //   TasksState(
    //     pendingTasks: List.from(state.pendingTasks)
    //       ..remove(event.oldTask)
    //       ..insert(0, event.newTask),
    //     completedTasks: state.completedTasks..remove(event.oldTask),
    //     favoriteTasks: favouriteTasks,
    //     removedTasks: state.removedTasks,
    //   ),
    // );
  }
}

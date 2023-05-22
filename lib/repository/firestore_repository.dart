import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:get_storage/get_storage.dart';

class FirestoreRepository {
  static Future<void> createTask({required Task task}) async {
    try {
      await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .doc(task.id)
          .set(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Task>> getTask() async {
    List<Task> tasks = [];

    try {
      final data = await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .get();

      for (var task in data.docs) {
        tasks.add(Task.fromMap(task.data()));
      }

      return tasks;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> updateTask({Task? task}) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(GetStorage().read('email'));

      data.doc(task!.id).update(
            task.toMap(),
          );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deleteTask({Task? task}) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(GetStorage().read('email'));

      data.doc(task!.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> onDeleteAllTask({List<Task>? tasks}) async {
    try {
      final data = FirebaseFirestore.instance.collection(
        GetStorage().read('email'),
      );

      tasks?.forEach((task) {
        data.doc(task.id).delete();
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

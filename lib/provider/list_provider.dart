import 'package:Todo_List/firestore_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../moduls/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> list = [];
  DateTime selectedDate = DateTime.now();

  ListProvider() {
    initDataList();
  }

  Future<void> initDataList() async {
    List<QueryDocumentSnapshot<Task>> docSnapshot =
        await FirestoreUtils.getFromFirestore();
    list = docSnapshot.map((doc) {
      return doc.data();
    }).toList();

    list.sort((task1, task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });
    list = list.where((task) {
      if (task.dateTime.year == selectedDate.year &&
          task.dateTime.month == selectedDate.month &&
          task.dateTime.day == selectedDate.day) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    selectedDate = newDate;
    initDataList();
    notifyListeners();
  }

  void changeTaskState(Task task, bool state) {
    task.isDone = state;
    initDataList();
    notifyListeners();
  }

  void filterdata() {
    list = list.where((task) {
      if (task.dateTime.year == selectedDate.year &&
          task.dateTime.month == selectedDate.month &&
          task.dateTime.day == selectedDate.day) {
        return true;
      }
      return false;
    }).toList();

    notifyListeners();
  }

  void finishTask(Task task) async {
    task.isDone = true;
    await FirestoreUtils.getCollections()
        .doc(task.id)
        .update(task.toFirestore());
    notifyListeners();
  }

  bool isDone(Task task) {
    return task.isDone;
  }
}

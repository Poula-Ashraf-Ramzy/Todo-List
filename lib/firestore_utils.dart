import 'package:Todo_List/moduls/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUtils {
  static CollectionReference<Task> getCollections() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFirestore(snapshot.data()!),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addToFirestore(Task task) {
    var docref = getCollections().doc();
    task.id = docref.id;
    return docref.set(task);
  }

  static Future<List<QueryDocumentSnapshot<Task>>> getFromFirestore() async {
    QuerySnapshot<Task> snapshot = await getCollections().get();
    List<QueryDocumentSnapshot<Task>> list = snapshot.docs;
    return list;
  }

  static Future<void> updateDate(Task task) {
    return getCollections().doc(task.id).update(task.toFirestore());
  }
}

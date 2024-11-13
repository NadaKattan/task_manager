import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userModel, options) => userModel.toJson(),
          );
  static CollectionReference<TaskModel> getTaskCollection(userId) =>
      getUserCollection().doc(userId).collection('tasks').withConverter(
            fromFirestore: (snapshot, options) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (taskModel, options) => taskModel.toJson(),
          );

  static Future<void> addTaskToFirestore(TaskModel task,userId) {
    CollectionReference<TaskModel> tasksCollection = getTaskCollection(userId);
    DocumentReference<TaskModel> doc = tasksCollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFirestore(userId) async {
    CollectionReference<TaskModel> tasksCollection = getTaskCollection(userId);
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirestore(taskId,userId) async {
    CollectionReference<TaskModel> tasksCollection = getTaskCollection(userId);
    return tasksCollection.doc(taskId).delete();
  }

  static Future<void> editTaskInFirestore(taskId, taskModel,userId) async {
    CollectionReference<TaskModel> tasksCollection = getTaskCollection(userId);
     DocumentReference<TaskModel> doc = tasksCollection.doc(taskId);
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }
  static Future<UserModel> register({required String name,required String email,required String password,}) async {
    CollectionReference<UserModel> usersCollection = getUserCollection();
    UserCredential credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    UserModel user=UserModel(id: credential.user!.uid, email: email, name: name);
    await usersCollection.doc(user.id).set(user);
    return user;
  }
  static Future<UserModel> login({required String email,required String password,}) async {
    CollectionReference<UserModel> usersCollection = getUserCollection();
    UserCredential credential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    DocumentSnapshot<UserModel> docSnapshot=
    await usersCollection.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }
   static Future<void> logout() async {
     return await FirebaseAuth.instance.signOut();
   }
}

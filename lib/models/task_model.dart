import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;
  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});
  TaskModel.fromJson(json)
      : this(
          date: (json["date"] as Timestamp).toDate(),
          title: json["title"],
          description: json["description"],
          id: json["id"],
          isDone: json["isDone"],
        );
  Map<String, dynamic> toJson() => {
        "date": Timestamp.fromDate(date),
        "title": title,
        "description": description,
        "id": id,
        "isDone": isDone,
      };
}

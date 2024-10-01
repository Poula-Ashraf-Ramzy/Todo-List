

class Task {
  static const String collectionName = 'Tasks';
  String id;

  String name;
  String description;
  DateTime dateTime;
  int hour;
  int min;
  bool isDone;

  Task(
      {this.id = '',
      required this.name,
      required this.description,
      required this.dateTime,
      required this.hour,
      required this.min,
      this.isDone = false});

  Task.fromFirestore(Map<String, dynamic> map)
      : this(
            id: map['id'] as String,
            name: map['name'] as String,
            description: map['description'] as String,
            dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
            hour: map['hour'] as int,
            min: map['min'] as int,
            isDone: map['isDone'] as bool);

  Map<String, dynamic> toFirestore() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'dateTime': this.dateTime.millisecondsSinceEpoch,
      'hour': this.hour,
      'min': this.min,
      'isDone': this.isDone
    };
  }
}

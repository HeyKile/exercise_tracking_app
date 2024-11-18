import 'package:uuid/uuid.dart';

class Workout{
  String? id;
  final List<Exercise> completed;
  final int time;
  final String workoutName;
  final DateTime date;
  int intensity;
  final List<Tag> tags;

  Workout({String? id, required this.completed, required this.time, required this.workoutName, required this.date, required this.intensity, required this.tags})
  : id = id ?? const Uuid().v4();

  // workout to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completed': completed.map((exercise) => exercise.toJson()).toList(),
      'time': time,
      'workoutName': workoutName,
      'date': date.toIso8601String(),
      'intensity': intensity,
      'tags': tags.map((tags) => tags.toJson()).toList(),
    };
  }

  void updateIntensity(int newIntensity) {
    intensity = newIntensity;
  }
  
  // json to workout
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] as String,
      completed: (json['completed'] as List<dynamic>)
          .map((exercise) => Exercise.fromJson(exercise))
          .toList(),
      time: json['time'],
      workoutName: json['workoutName'],
      date: DateTime.parse(json['date']),
      intensity: json['intensity'],
      tags: (json['tags'] as List<dynamic>)
          .map((tag) => Tag.fromJson(tag))
          .toList(),
    );
  }


}

class Tag {
  final String name;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
    );
  }
  
  Tag({required this.name});
}

class Exercise{
  String name;
  List<Set> sets;
  int time;

  Exercise({required this.name, required this.sets, required this.time});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets.map((sets) => sets.toJson()).toList(),
      'time': time,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      sets: (json['sets'] as List<dynamic>)
      .map((sets) => Set.fromJson(sets))
      .toList(),
      time: json['time'],
    );
  }

}

class Set{
  int reps;
  int weight;

  Set({
    required this.reps,
    required this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'reps': reps,
      'weight': weight,
    };
  }

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      reps: json['reps'],
      weight: json['weight'],
    );
  }
}

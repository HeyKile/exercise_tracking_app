import 'package:uuid/uuid.dart';

class Workout{
  String? id;
  final List<WorkoutExercise> completed;
  final String time;
  final String workoutName;
  final DateTime date;
  int intensity;
  final List<Tag> tags;

  Workout({
    String? id,
    required this.completed,
    required this.time,
    required this.workoutName,
    required this.date,
    required this.intensity,
    required this.tags
  }) : id = id ?? const Uuid().v4();

  // workout to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completed': completed.map((exercise) => exercise.toJson()).toList(),
      'time': time.toString(),
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
          .map((exercise) => WorkoutExercise.fromJson(exercise))
          .toList(),
      time: json['time'] as String,
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

class WorkoutExercise{
  String name;
  List<Set> sets;
  String notes;
  String? id;

  WorkoutExercise({id, required this.name, required this.sets, required this.notes}) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets.map((sets) => sets.toJson()).toList(),
      'notes': notes
    };
  }

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      name: json['name'],
      sets: (json['sets'] as List<dynamic>)
      .map((sets) => Set.fromJson(sets))
      .toList(),
      notes: json['notes'],
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

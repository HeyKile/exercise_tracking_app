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

  void updateIntensity(int newIntensity) {
    intensity = newIntensity;
  }

}

class Tag {
  final String name;

  
  Tag({required this.name});
}

class WorkoutExercise{
  String name;
  List<Set> sets;
  String notes;
  String? id;

  WorkoutExercise({
    id,
    required this.name,
    required this.sets,
    required this.notes
  }) : id = id ?? const Uuid().v4();

}

class Set{
  int? reps;
  int? weight;
  String unit;
  int? distance;
  int? time;

  Set({
    required this.reps,
    required this.weight,
    required this.unit, 
    required this.time,
    required this.distance,
  });
}

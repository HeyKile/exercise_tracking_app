import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:uuid/uuid.dart';

class Workout{
  String? id;
  final List<Exercise> completed;
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


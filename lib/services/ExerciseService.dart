import 'dart:convert';
import 'dart:io';
import '../models/ExerciseModel.dart';

class ExerciseService {
  Future<List<Exercise>> fetchExercises() async {
    try {
      String filePath = 'lib/data/exercises.json';
      File file = File(filePath);
      String fileContent = await file.readAsString();
      try {
        List<dynamic> jsonList = jsonDecode(fileContent);
        List<Exercise> exercises = jsonList.map((json) => Exercise.fromJson(json)).toList();
        return exercises;
      }
      catch (_) {
        return [];
      }
    }
    catch (e) {
      print('error parsing file: $e');
      return [];
    }
  }

  Future<bool> saveExercise(Map<String, dynamic> exercise) async {
    try {
      String filePath = 'lib/data/exercises.json';
      File file = File(filePath);
      String fileContent = await file.readAsString();
      List<dynamic> jsonExercisesList;
      try {
        jsonExercisesList = jsonDecode(fileContent);
      } catch (_) {
        jsonExercisesList = [];
      }
      jsonExercisesList.add(exercise);
      String updatedJson = jsonEncode(jsonExercisesList);
      await file.writeAsString(updatedJson);
      return true;
    } catch (e) {
      print('Error saving the exercise: $e');
      return false;
    }
  }

  Future<List<Exercise>> createMockExercises() async {
    return [
      Exercise(
        id: 0,
        name: "Barbell Squat",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 1,
        name: "Barbell Bench Press",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 2,
        name: "Run",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.distance, display: "Distance", unit: "mi"),
          const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "mins"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 3,
        name: "Deadlift",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 4,
        name: "Pull-Up",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 5,
        name: "Dumbbell Shoulder Press",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 6,
        name: "Cycling",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.distance, display: "Distance", unit: "mi"),
          const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "mins"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 7,
        name: "Plank",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "secs"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 8,
        name: "Barbell Row",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 9,
        name: "Dumbbell Curl",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 10,
        name: "Kettlebell Swing",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 11,
        name: "Push-Up",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 12,
        name: "Jump Rope",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "mins"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 13,
        name: "Lat Pulldown",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 14,
        name: "Seated Row",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 15,
        name: "Leg Press",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 16,
        name: "Swimming",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.distance, display: "Distance", unit: "m"),
          const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "mins"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 17,
        name: "Mountain Climbers",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
          const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "secs"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 18,
        name: "Burpees",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 19,
        name: "Overhead Press",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 20,
        name: "Step-Ups",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 21,
        name: "Lunges",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 22,
        name: "Bicycle Crunch",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 23,
        name: "Wall Sit",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "secs"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 24,
        name: "Dumbbell Fly",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 25,
        name: "Hip Thrust",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 26,
        name: "Rowing Machine",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.distance, display: "Distance", unit: "m"),
          const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "mins"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 27,
        name: "Box Jump",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 28,
        name: "Farmer's Carry",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.distance, display: "Distance", unit: "m"),
        ],
        isCustom: false,
      ),
      Exercise(
        id: 29,
        name: "Pull Through",
        trackedStats: [
          const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
          const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
        ],
        isCustom: false,
      ),
    ];
  }

}
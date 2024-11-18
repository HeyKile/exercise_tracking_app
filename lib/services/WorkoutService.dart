import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/WorkoutModel.dart';

class WorkoutService {

  Future<List<Workout>> fetchWorkouts() async {
    try {
      String filePath = 'lib/data/workout.json';
      File file = File(filePath);

      print("Fetching workouts from $filePath...");

      if (await file.exists()) {
        print("Workout file exists. Reading content...");
        String fileContent = await file.readAsString();
        print("File content: $fileContent");
        List<dynamic> jsonList = jsonDecode(fileContent);
        List<Workout> workouts = jsonList.map((json) => Workout.fromJson(json)).toList();
        print("Decoded workouts: $workouts");
        return workouts;
      } else {
        print("Workout file does not exist. Returning empty list.");
        return [];
      }
    } catch (e) {
      print('Error reading workouts file: $e');
      return [];
    }
  }

  Future<bool> saveWorkout(Map<String, dynamic> newWorkoutJson) async {
    try {
      String filePath = 'lib/data/workout.json';
      File file = File(filePath);

      print("Saving workout to $filePath..."); // Debug print
      print("New workout data: $newWorkoutJson"); // Debug print

      List<dynamic> jsonWorkoutsList;
      if (await file.exists()) {
        print("Workout file exists. Reading current content...");
        String fileContent = await file.readAsString();
        print("Current file content: $fileContent");
        jsonWorkoutsList = jsonDecode(fileContent);
      } else {
        print("Workout file does not exist. Creating a new list...");
        jsonWorkoutsList = [];
      }
      jsonWorkoutsList.add(newWorkoutJson);
      String updatedJson = jsonEncode(jsonWorkoutsList);
      print("Updated JSON content: $updatedJson");
      await file.writeAsString(updatedJson);
      return true;
    } catch (e) {
      print('Error saving the workout: $e');
      return false;
    }
  }
}

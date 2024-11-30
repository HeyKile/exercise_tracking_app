import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/WorkoutModel.dart';

class WorkoutService {

  // Future<List<Workout>> fetchWorkouts() async {
  //   try {
  //     String filePath = 'lib/data/workout.json';
  //     File file = File(filePath);

  //     print("Fetching workouts from $filePath...");

  //     if (await file.exists()) {
  //       print("Workout file exists. Reading content...");
  //       String fileContent = await file.readAsString();
  //       print("File content: $fileContent");
  //       List<dynamic> jsonList = jsonDecode(fileContent);
  //       List<Workout> workouts = jsonList.map((json) => Workout.fromJson(json)).toList();
  //       print("Decoded workouts: $workouts");
  //       return workouts;
  //     } else {
  //       print("Workout file does not exist. Returning empty list.");
  //       return [];
  //     }
  //   } catch (e) {
  //     print('Error reading workouts file: $e');
  //     return [];
  //   }
  // }

  List<Workout> createMockWorkouts() {
    return [
      Workout(
        id: "f882cc45-aaf1-4025-9b5d-87d2a29911e3",
        completed: [
          WorkoutExercise(
            name: "Leg Press",
            sets: [
              Set(
                reps: 12,
                weight: 1020
              ),
              Set(
                reps: 10,
                weight: 110
              )
            ],
            notes: ""
          )
        ],
        time: "00:00:00",
        workoutName: "Cool Workout",
        date: DateTime.parse("2024-11-21T11:21:40.980995"),
        intensity: 0,
        tags: []
      ),
    ];
  }

  // Future<bool> saveWorkout(Map<String, dynamic> newWorkoutJson) async {
  //   try {
  //     String filePath = 'lib/data/workout.json';
  //     File file = File(filePath);

  //     print("Saving workout to $filePath..."); // Debug print
  //     print("New workout data: $newWorkoutJson"); // Debug print

  //     List<dynamic> jsonWorkoutsList;
  //     if (await file.exists()) {
  //       print("Workout file exists. Reading current content...");
  //       String fileContent = await file.readAsString();
  //       print("Current file content: $fileContent");
  //       jsonWorkoutsList = jsonDecode(fileContent);
  //     } else {
  //       print("Workout file does not exist. Creating a new list...");
  //       jsonWorkoutsList = [];
  //     }
  //     jsonWorkoutsList.add(newWorkoutJson);
  //     String updatedJson = jsonEncode(jsonWorkoutsList);
  //     print("Updated JSON content: $updatedJson");
  //     await file.writeAsString(updatedJson);
  //     return true;
  //   } catch (e) {
  //     print('Error saving the workout: $e');
  //     return false;
  //   }
  // }

  // Future<bool> saveUpdatedWorkout(Workout updatedWorkout) async {
  //   try {
  //     String filePath = 'lib/data/workout.json';
  //     File file = File(filePath);
  //     List<Map<String, dynamic>> workouts = [];

  //     if (await file.exists()) {
  //       String content = await file.readAsString();
  //       workouts = List<Map<String, dynamic>>.from(json.decode(content));

  //       int index = workouts.indexWhere((w) => w['id'] == updatedWorkout.id);

  //       if (index != -1) {
  //         workouts[index] = updatedWorkout.toJson();  
  //       } else {
  //         debugPrint("Workout not found in the list!");
  //         return false;
  //       }
  //     }

  //     await file.writeAsString(json.encode(workouts));
  //     debugPrint("Workout updated successfully!");
  //     return true;
  //   } catch (e) {
  //     debugPrint("Error saving updated workout: $e");
  //     return false;
  //   }
  // }
}

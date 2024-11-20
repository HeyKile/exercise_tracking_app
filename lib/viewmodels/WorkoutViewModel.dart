import 'dart:convert';
import 'dart:io';

import 'package:exercise_tracking_app/services/WorkoutService.dart';
import 'package:flutter/material.dart';
import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:path_provider/path_provider.dart';

class WorkoutViewModel extends ChangeNotifier{
  Workout? _currentWorkout;
  List<Workout> _allWorkouts = [];

  final WorkoutService _workoutService = WorkoutService();

  Workout? get currentWorkout => _currentWorkout;
  List<Workout> get allWorkouts => _allWorkouts;

  void addExercise(String name, List<Set> sets, String time){
    if(_currentWorkout != null){
      _currentWorkout!.completed.add(WorkoutExercise(name: name, sets: sets));
      debugPrint("Added exercise: $name");
      notifyListeners();
    }
    else {
      debugPrint("Error: No workout started!");
    }
  }

  Future<void> updateIntensity(int newIntensity, Workout? curr) async {
    if (curr != null) {
      curr.updateIntensity(newIntensity); 
      debugPrint("Updated intensity: $newIntensity");

      final success = await _workoutService.saveUpdatedWorkout(curr);

      if (success) {
        notifyListeners();
      } else {
        debugPrint("Failed to update workout intensity!");
      }
    }
  }

  Future<void> saveWorkout(Workout workout) async {
    debugPrint("Saving workout: ${workout.toJson()}");
    final success = await _workoutService.saveWorkout(workout.toJson());

    if(success){
      debugPrint("Workout saved successfully!");
      _allWorkouts = await _workoutService.fetchWorkouts();
      debugPrint("All workouts after saving: ${_allWorkouts.map((w) => w.toJson()).toList()}");
      notifyListeners();
    }
    else {
      debugPrint("Failed to save workout!");
    }
  }

  Future<void> loadWorkouts() async {
    debugPrint("Loading workouts...");
    _allWorkouts = await _workoutService.fetchWorkouts();
    debugPrint("Loaded workouts: ${_allWorkouts.map((w) => w.toJson()).toList()}");
    notifyListeners();
  }
}
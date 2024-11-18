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

  void startWorkout(String workoutName){
    _currentWorkout = Workout(
      completed: [], 
      time: 0, 
      workoutName: workoutName, 
      date: DateTime.now(), 
      intensity: 0,
      tags: []
    );
    debugPrint("Started new workout: ${_currentWorkout!.toJson()}");
    notifyListeners();
  }

  void addExercise(String name, List<Set> sets, int time){
    if(_currentWorkout != null){
      _currentWorkout!.completed.add(Exercise(name: name, sets: sets, time: time));
      debugPrint("Added exercise: $name");
      notifyListeners();
    }
    else {
      debugPrint("Error: No workout started!"); // Debug print
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
      debugPrint("Failed to save workout!"); // Debug print on failure
    }
  }

  Future<void> loadWorkouts() async {
    debugPrint("Loading workouts...");
    _allWorkouts = await _workoutService.fetchWorkouts();
    debugPrint("Loaded workouts: ${_allWorkouts.map((w) => w.toJson()).toList()}");
    notifyListeners();
  }
}
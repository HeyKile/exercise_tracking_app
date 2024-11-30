import 'package:exercise_tracking_app/services/WorkoutService.dart';
import 'package:flutter/material.dart';
import 'package:exercise_tracking_app/models/WorkoutModel.dart';

class WorkoutViewModel extends ChangeNotifier{
  Workout? _currentWorkout;
  List<Workout> _allWorkouts = [];

  final WorkoutService _workoutService = WorkoutService();

  Workout? get currentWorkout => _currentWorkout;
  List<Workout> get allWorkouts => _allWorkouts;

  void addExercise(String name, List<Set> sets, String notes){
    if(_currentWorkout != null){
      _currentWorkout!.completed.add(WorkoutExercise(name: name, sets: sets, notes: notes));
      debugPrint("Added exercise: $name");
      notifyListeners();
    }
    else {
      debugPrint("Error: No workout started!");
    }
  }

  void updateNotes(String? workoutId, String exerciseName, String notes) async {
    final workout = _allWorkouts.firstWhere((w) => w.id == workoutId);
    final exercise = workout.completed.firstWhere((e) => e.name == exerciseName);
    exercise.notes = notes;
    notifyListeners();
  }

  Future<void> updateIntensity(int newIntensity, Workout? curr) async {
    if (curr != null) {
      curr.updateIntensity(newIntensity); 
      final replacementIndex = _allWorkouts.indexWhere((w) => w.id == curr.id);
      if (replacementIndex != -1) {
        _allWorkouts[replacementIndex] = curr;
      }
    }
  }

  Future<void> saveWorkout(Workout workout) async {
    if (_allWorkouts.isEmpty) {
      _allWorkouts = _workoutService.createMockWorkouts();
    }
    _allWorkouts.add(workout);
  }

  Future<void> loadWorkouts() async {
    debugPrint("Loading workouts...");
    if (_allWorkouts.isEmpty) {
      _allWorkouts = _workoutService.createMockWorkouts();
    }
    notifyListeners();
  }
}


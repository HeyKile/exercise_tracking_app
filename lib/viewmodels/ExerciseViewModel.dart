import 'package:flutter/material.dart';
import '../models/ExerciseModel.dart';
import '../services/ExerciseService.dart';

enum ExerciseTab { allExercises, customExercises }

class ExerciseViewModel extends ChangeNotifier {
  List<Exercise> exercises = <Exercise>[];
  List<Exercise> customExercises = <Exercise>[];
  List<Exercise> _filteredExercises = <Exercise>[];

  final ExerciseService _exerciseService = ExerciseService();

  List<Exercise> get filteredExercises => _filteredExercises;

  ExerciseViewModel() {
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    if (exercises.isEmpty) {
      exercises = await _exerciseService.createMockExercises();
    }
    getCurrentExercises(ExerciseTab.allExercises, "");
    notifyListeners();
  }

  void getCurrentExercises(ExerciseTab curTab, String search) {
    List<Exercise> filteredExercises = exercises;
    filteredExercises.addAll(customExercises);
    if (curTab == ExerciseTab.customExercises) {
      filteredExercises = filteredExercises
        .where((exercise) => exercise.isCustom)
        .toList();
    }
    if (search != "") {
      filteredExercises = filteredExercises
        .where((exercise) => exercise.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
    }
    _filteredExercises = filteredExercises;
    notifyListeners();
  }

  Future<bool> addCustomExercse(String name, bool hasDistance, bool hasRep, bool hasWeight, bool hasTime) async {
    try {
      Exercise exercise = Exercise.fromInput(name, hasDistance, hasRep, hasWeight, hasTime);
      if (exercises.isEmpty) {
        await fetchExercises();
      }
      exercises.add(exercise);
      getCurrentExercises(ExerciseTab.customExercises, "");
      return true;
    }
    catch (_) {
      return false;
    }
  }

  Future<Exercise?> getExerciseById(int id) async {
    if (exercises.isEmpty) {
      exercises = await _exerciseService.createMockExercises();
    }
    if (id < exercises.length) {
      return exercises.firstWhere((elem) => elem.id == id);
    }
    else {
      return null;
    }
  }

}
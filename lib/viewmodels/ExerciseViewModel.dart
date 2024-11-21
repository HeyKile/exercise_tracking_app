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
    exercises = await _exerciseService.fetchExercises();
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
    Exercise exercise = Exercise.fromInput(name, hasDistance, hasRep, hasWeight, hasTime);
    Map<String, dynamic> exerciseJson = {
      "id": exercise.id,
      "name": exercise.name,
      "isCustom": exercise.isCustom,
      "trackedStats": exercise.trackedStats.map((stat) => {
        "type": stat.type.toString().split('.').last[0].toUpperCase() + stat.type.toString().split('.').last.substring(1).toLowerCase(),
        if (stat.unit != null) "unit": stat.unit
      }).toList()
    };
    bool res = await _exerciseService.saveExercise(exerciseJson);
    await fetchExercises();
    getCurrentExercises(ExerciseTab.customExercises, "");
    return res;
  }

}
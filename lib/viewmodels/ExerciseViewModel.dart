import 'package:flutter/material.dart';
import '../models/ExerciseModel.dart';
import '../services/ExerciseService.dart';

class ExerciseViewModel extends ChangeNotifier {
  List<Exercise> exercises = <Exercise>[];

  final ExerciseService _exerciseService = ExerciseService();

  ExerciseViewModel() {
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    exercises = await _exerciseService.fetchExercises();
    notifyListeners();
  }

}
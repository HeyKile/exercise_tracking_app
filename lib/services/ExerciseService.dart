import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/ExerciseModel.dart';

class ExerciseService {
  Future<List<Exercise>> fetchExercises() async {
    try {
      String fileContent = await rootBundle.loadString('lib/data/exercises.json');
      List<dynamic> jsonList = jsonDecode(fileContent);
      List<Exercise> exercises = jsonList.map((json) => Exercise.fromJson(json)).toList();
      return exercises;
    }
    catch (e) {
      print('error parsing file: $e');
      return [];
    }
  }
}
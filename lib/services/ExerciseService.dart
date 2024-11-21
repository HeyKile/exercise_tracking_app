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

}
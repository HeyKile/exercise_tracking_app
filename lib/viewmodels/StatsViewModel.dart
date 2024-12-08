
import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsViewModel extends ChangeNotifier {
  List<PieChartSectionData> genCurChartSections(int touchedIndex, double screenWidth) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      String title = "";
      switch (i) {
        case 0:
          title = isTouched ? 'Swim (30%)' : 'Swim';
          break;
        case 1:
          title = isTouched ? 'Lift (50%)' : 'Lift';
          break;
        case 2:
          title = isTouched ? 'Run (20%)' : 'Run';
          break;
        default:
          break;
      }

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue[400],
            value: 3,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange[700],
            value: 5,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue[800],
            value: 2,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        default:
          return PieChartSectionData();
      }
    });
  }
  List<ExerciseStats> genExerciseStats(){
    List<ExerciseStats> trackedExercises = <ExerciseStats>[]; 

    trackedExercises.add(ExerciseStats(exerciseName: "Squats", exerciseId: 1, goalThreshold: 150.0, currPR: 140, category: "Lift"));
    trackedExercises.add(ExerciseStats(exerciseName: "Bench Press", exerciseId: 2, goalThreshold: 100, currPR: 60, category: "Lift"));
    trackedExercises.add(ExerciseStats(exerciseName: "Hammer Curls", exerciseId: 3, goalThreshold: 40, currPR: 35, category: "Lift"));
    trackedExercises.add(ExerciseStats(exerciseName: "5K", exerciseId: 4, goalThreshold: 21, currPR: 22.4, category: "Run"));
    trackedExercises.add(ExerciseStats(exerciseName: "100 Free", exerciseId: 5, goalThreshold: 58.3, currPR: 59.45, category: "Swim"));
    trackedExercises.add(ExerciseStats(exerciseName: "100 Fly", exerciseId: 6, goalThreshold: 68, currPR: 68.5, category: "Swim"));
    return trackedExercises;
  }

}


class ExerciseStats {
  String exerciseName;
  int exerciseId;
  double goalThreshold;
  double currPR;
  String category;

  ExerciseStats({required this.exerciseName, required this.exerciseId, required this.goalThreshold, required this.currPR, required this.category});
}
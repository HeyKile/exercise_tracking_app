
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

    trackedExercises.add(ExerciseStats(lowest: 100, exerciseName: "Squats", exerciseId: 1, goalThreshold: 150.0, currPR: 140, category: "Lift",
    history: genExerciseHistory("Squats")));
    trackedExercises.add(ExerciseStats(lowest: 40, exerciseName: "Bench Press", exerciseId: 2, goalThreshold: 100, currPR: 60, category: "Lift", history: genExerciseHistory("Bench Press")));
    trackedExercises.add(ExerciseStats(lowest: 25, exerciseName: "Hammer Curls", exerciseId: 3, goalThreshold: 40, currPR: 35, category: "Lift", history: genExerciseHistory("Hammer Curls")));
    trackedExercises.add(ExerciseStats(lowest: 25, exerciseName: "5K", exerciseId: 4, goalThreshold: 21, currPR: 22.4, category: "Run", history: genExerciseHistory("5K")));
    trackedExercises.add(ExerciseStats(lowest: 61, exerciseName: "100 Free", exerciseId: 5, goalThreshold: 58.3, currPR: 59.45, category: "Swim", history: genExerciseHistory("100 Free")));
    trackedExercises.add(ExerciseStats(lowest: 70, exerciseName: "100 Fly", exerciseId: 6, goalThreshold: 68, currPR: 68.5, category: "Swim", history: genExerciseHistory("100 Fly")));
    return trackedExercises;
  }
  List<FlSpot> genExerciseChartData(String exerciseName){
    switch (exerciseName) {
        case "Squats":
          return [
            FlSpot(0, 100),
            FlSpot(2.6, 110),
            FlSpot(4.9, 110),
            FlSpot(6.8, 115),
            FlSpot(8, 120),
            FlSpot(9.5, 135),
            FlSpot(11, 140),
          ];
        case "Bench Press":
          return [
            FlSpot(0, 40),
            FlSpot(2.6, 40),
            FlSpot(4.9, 50),
            FlSpot(6.8, 55),
            FlSpot(8, 55),
            FlSpot(9.5, 60),
            FlSpot(11, 55),
          ];
        case "Hammer Curls":
          return [
            FlSpot(0, 25),
            FlSpot(2.6, 25),
            FlSpot(4.9, 30),
            FlSpot(6.8, 30),
            FlSpot(8, 30),
            FlSpot(9.5, 35),
            FlSpot(11, 35),
          ];
        case "5K":
          return [
            FlSpot(0, 25),
            FlSpot(2.6, 25.5),
            FlSpot(4.9, 24),
            FlSpot(6.8, 24.2),
            FlSpot(8, 23.7),
            FlSpot(9.5, 22.4),
            FlSpot(11, 23.6),
          ];
        case "100 Free":
          return [
            FlSpot(0, 60),
            FlSpot(2.6, 61),
            FlSpot(4.9, 60.2),
            FlSpot(6.8, 60.4),
            FlSpot(8, 60),
            FlSpot(9.5, 59.6),
            FlSpot(11, 59.45),
          ];
        case "100 Fly":
          return [
            FlSpot(0, 70),
            FlSpot(2.6, 69.7),
            FlSpot(4.9, 69.4),
            FlSpot(6.8, 69),
            FlSpot(8, 69),
            FlSpot(9.5, 68.5),
            FlSpot(11, 68.7),
          ];
        default:
          return [];
      }

  }
  List<History> genExerciseHistory(String exerciseName){
    switch (exerciseName) {
        case "Squats":
          return [
            History(date:"9/14", amount: 100),
            History(date:"9/27", amount: 110),
            History(date:"9/27", amount: 110),
            History(date:"10/25", amount: 115),
            History(date:"11/13", amount: 120),
            History(date:"11/28", amount: 135),
            History(date:"12/3", amount: 140),
          ];
        case "Bench Press":
          return [
            History(date:"9/14", amount: 40),
            History(date:"9/27", amount: 40),
            History(date:"9/27", amount: 50),
            History(date:"10/25", amount: 55),
            History(date:"11/13", amount: 55),
            History(date:"11/28", amount: 60),
            History(date:"12/3", amount: 55),
          ];
        case "Hammer Curls":
          return [
            History(date:"9/14", amount: 25),
            History(date:"9/27", amount: 25),
            History(date:"9/27", amount: 30),
            History(date:"10/25", amount: 30),
            History(date:"11/13", amount: 30),
            History(date:"11/28", amount: 35),
            History(date:"12/3", amount: 35),
          ];
        case "5K":
          return [
            History(date:"9/14", amount: 25),
            History(date:"9/27", amount: 25.5),
            History(date:"9/27", amount: 24),
            History(date:"10/25", amount: 24.2),
            History(date:"11/13", amount: 23.7),
            History(date:"11/28", amount: 22.4),
            History(date:"12/3", amount: 23.6),
          ];
        case "100 Free":
          return [
            History(date:"9/14", amount: 60),
            History(date:"9/27", amount: 61),
            History(date:"9/27", amount: 60.2),
            History(date:"10/25", amount: 60.4),
            History(date:"11/13", amount: 60),
            History(date:"11/28", amount: 59.6),
            History(date:"12/3", amount: 59.45),
          ];
        case "100 Fly":
          return [
            History(date:"9/14", amount: 70),
            History(date:"9/27", amount: 69.7),
            History(date:"9/27", amount: 69.4),
            History(date:"10/25", amount: 69),
            History(date:"11/13", amount: 69),
            History(date:"11/28", amount: 68.5),
            History(date:"12/3", amount: 68.7),
          ];
        default:
          return [];
      }

  }

}


class ExerciseStats {
  String exerciseName;
  int exerciseId;
  double goalThreshold;
  double currPR;
  String category;
  double lowest;
  List<History> history;

  ExerciseStats({required this.exerciseName, required this.exerciseId, required this.goalThreshold, required this.currPR, required this.category, required this.lowest, required this.history});
}

class History {
  String date;
  double amount;

  History({required this.date, required this.amount});
}
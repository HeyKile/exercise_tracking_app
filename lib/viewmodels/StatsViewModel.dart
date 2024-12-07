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
}
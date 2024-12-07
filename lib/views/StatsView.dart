import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/StatsViewModel.dart';

class StatsView extends StatefulWidget {

  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}


class _StatsViewState extends State<StatsView> {

  int _touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Your Weekly Workout Split"),
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 500,
                  minHeight: 200,
                  maxHeight: 500,
                ),
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            _touchedIndex = -1;
                            return;
                          }
                          _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: width * 0.13,
                    sections: genCurChartSections(width),
                  ),
                ),
              ),
            ],
          ),
        ]
      )
    );
  }

  List<PieChartSectionData> genCurChartSections(double screenWidth) {
    return List.generate(3, (i) {
      final isTouched = i == _touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? screenWidth * 0.12 : screenWidth * 0.10;
      final widgetSize = screenWidth * 0.06;
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
      final badgeOffset = isTouched ? screenWidth * 0.0026 : screenWidth * 0.0020;

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
            badgeWidget: Icon(
              Icons.pool,
              size: widgetSize,
            ),
            badgePositionPercentageOffset: badgeOffset,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow[800],
            value: 5,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: Icon(
              Icons.fitness_center,
              size: widgetSize,
            ),
            badgePositionPercentageOffset: badgeOffset,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green[600],
            value: 2,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: Icon(
              Icons.directions_run,
              size: widgetSize,
            ),
            badgePositionPercentageOffset: badgeOffset,
          );
        default:
          return PieChartSectionData();
      }
    });
  }
}
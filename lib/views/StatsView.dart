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
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
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
            centerSpaceRadius: width * 0.2,
            sections: genCurChartSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> genCurChartSections() {
    return List.generate(3, (i) {
      final isTouched = i == _touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      const widgetSize = 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          String curTitle = isTouched
            ? 'Swim (30%)'
            : 'Swim';
          return PieChartSectionData(
            color: Colors.blue[400],
            value: 3,
            title: curTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: const Icon(
              Icons.pool,
              size: widgetSize,
            ),
            badgePositionPercentageOffset: isTouched
              ? 1.13
              : 0.98,
          );
        case 1:
        String curTitle = isTouched
            ? 'Lift (50%)'
            : 'Lift';
          return PieChartSectionData(
            color: Colors.yellow[800],
            value: 5,
            title: curTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: const Icon(
              Icons.fitness_center,
              size: widgetSize,
            ),
            badgePositionPercentageOffset: isTouched
              ? 1.13
              : 0.98,
          );
        case 2:
          String curTitle = isTouched
            ? 'Run (20%)'
            : 'Run';
          return PieChartSectionData(
            color: Colors.green[600],
            value: 2,
            title: curTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: const Icon(
              Icons.directions_run,
              size: widgetSize,
            ),
            badgePositionPercentageOffset: isTouched
              ? 1.13
              : 0.98,
          );
        default:
          return PieChartSectionData();
      }
    });
  }
}
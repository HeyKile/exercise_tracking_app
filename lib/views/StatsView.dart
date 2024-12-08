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
    Color headerBackgroundColor = Colors.transparent;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: const Text(
              "Your Weekly Time Split",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: headerBackgroundColor,
                constraints: BoxConstraints(
                  minWidth: 200,
                  maxWidth: width * 0.5,
                  minHeight: 200,
                  maxHeight: 250,
                ),
                child: Consumer<StatsViewModel>(
                  builder: (context, statsViewModel, child) {
                    return PieChart(
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
                        centerSpaceRadius: 60,
                        sections: statsViewModel.genCurChartSections(_touchedIndex, width),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: const Text(
              "Stats Per Exercise",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 15.0),
            child: const Text(
              "Lift:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
           Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 15.0),
            child: const Text(
              "Swim:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
           Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 15.0),
            child: const Text(
              "Run:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          )
          
        ]
      )
    );
  }
}
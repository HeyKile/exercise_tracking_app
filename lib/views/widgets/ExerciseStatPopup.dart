import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../viewmodels/StatsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exercise_tracking_app/views/MainView.dart';
import '../../viewmodels/StatsViewModel.dart';


class ExerciseStatPopup extends StatefulWidget{
  final ExerciseStats exercise;
  const ExerciseStatPopup({super.key, required this.exercise});

  @override
  State<ExerciseStatPopup> createState() => _ExerciseStatPopupState();

}

class _ExerciseStatPopupState extends State<ExerciseStatPopup>{
  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      body:SingleChildScrollView( 
      child: Column(
        children:[
          Container( 
            width: MediaQuery.of(context).size.width * 0.95, 
            height: 30,
            margin: const EdgeInsets.only(left:15.0, right: 15.0, top: 20.0, bottom: 20.0),
            //padding: new EdgeInsets.only(left: 30.0, right: 30.0, top: 3.0, bottom: 3.0),
            decoration: BoxDecoration(color: Color.fromARGB(255, 0, 149, 255), borderRadius: BorderRadius.circular(20)),
            child: Text(widget.exercise.exerciseName, textAlign: TextAlign.center ,style:TextStyle(color: Colors.white, fontSize: 20.0))),
            LineChartSample2(exercise: widget.exercise),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
            margin: const EdgeInsets.all(15.0),
            child: const Text(
              "Goal:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.exercise.goalThreshold}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
               
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: const Text(
              "Current Record:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.exercise.currPR}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                
              ),
            ),
          ),
          ],),
            Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: const Text(
              "History",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Column(children: getExerciseStats(widget.exercise)),
          CloseDisplay()])
    ));
}}

class ExerciseStatListItem extends StatelessWidget{
  const ExerciseStatListItem({required this.date, required this.units, required this.amount});
  final String units;
  final String date;
  final String amount;

    @override
  Widget build(BuildContext context) {
    return
    Container(
      margin: const EdgeInsets.only(left:15.0, right: 15.0, top: 10.0, bottom: 10.0),
      padding: new EdgeInsets.only(left: 15.0, top: 3.0, bottom: 3.0),
      decoration: BoxDecoration(color: Color.fromARGB(255, 0, 149, 255), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(child:Text(date, style: TextStyle(color:Colors.white))), 
          Expanded(child:Text("$amount $units", style: TextStyle(color:Colors.white))), 
          ],)
    );
  }
}

List<Widget> getExerciseStats(ExerciseStats exercise){
  List<Widget> historyList = [];
  for(History stat in exercise.history){
    String units = switch(exercise.category){
      "Run" => "min",
      "Swim" => "sec",
      _ => "lbs"
    };
    historyList.add(ExerciseStatListItem(date: stat.date, amount: stat.amount.toString(), units: units));
  }
  return historyList;
}

class CloseDisplay extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(children:[SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {
          // send info to workout view model to save workout in model
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainView(selectedIndex: 3),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          backgroundColor: const Color.fromRGBO(144, 238, 144, 1),
          padding: const EdgeInsets.all(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Close Display',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              )
            )
          ],
        ),
      ),
    )
    ]);
  }
}

class LineChartSample2 extends StatelessWidget {
  final ExerciseStats exercise;
  LineChartSample2({super.key, required this.exercise});
  

  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEP', style: style);
        break;
      case 5:
        text = const Text('OCT', style: style);
        break;
      case 8:
        text = const Text('NOV', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.blue,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.blue,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: switch(exercise.category){
              "Run" => 5,
              "Swim" => 3,
              _=>5
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: switch(exercise.category){
        "Run" =>
        exercise.currPR - 5.0,
        "Swim" =>
        exercise.currPR - 5.0,
        _ =>
          exercise.lowest - 5.0,
      },
      maxY:switch(exercise.category){
        "Run" =>
        exercise.lowest + 5.0,
        "Swim" =>
        exercise.lowest + 5.0,
        _ =>
          exercise.currPR + 5.0,
      },
      lineBarsData: [
        LineChartBarData(
          spots: genChartData(exercise.exerciseName),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

List<FlSpot> genChartData(String exerciseName){
  StatsViewModel statsVM = StatsViewModel();
  return statsVM.genExerciseChartData(exerciseName);
}

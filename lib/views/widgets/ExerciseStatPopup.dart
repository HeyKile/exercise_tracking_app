import 'package:fl_chart/fl_chart.dart';
import '../../viewmodels/StatsViewModel.dart';
import 'package:flutter/material.dart';



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
      appBar: AppBar(
        title: const Text('Exercise Stats'),
      ),
      body:SingleChildScrollView( 
      child: Column(
        children:[
          Container( 
            width: MediaQuery.of(context).size.width * 0.95, 
            height: 30,
            margin: const EdgeInsets.only(left:15.0, right: 15.0, top: 20.0, bottom: 0.0),
            decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 149, 255), borderRadius: BorderRadius.circular(20)),
            child: Text(widget.exercise.exerciseName, textAlign: TextAlign.center ,style: const TextStyle(color: Colors.white, fontSize: 20.0))),
            Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: const Text(
              "Progress",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
            ProgressLineChart(exercise: widget.exercise),
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
              style: const TextStyle(
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
              style: const TextStyle(
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
          HistoryDataTable(historyList: widget.exercise.history, category: widget.exercise.category,),
          const CloseDisplay()])
    ));
}}

class HistoryDataTable extends StatelessWidget {
  HistoryDataTable({super.key, required this.historyList, required this.category});
  List<History> historyList;
  String category;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 200,
      columns: <DataColumn>[
        const DataColumn(
          label: Expanded(
            child: Text(
              'Date',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              switch(category){
                "Run" => "min",
                "Swim" => "sec",
                _ => "lbs"
              },
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: getHistoryRows(historyList),
      
    );
  }
}

List<DataRow> getHistoryRows(List<History> historyList){
  List<DataRow> historyRows = <DataRow>[];
  for(History history in historyList){
        DataRow row = DataRow(cells: [
          DataCell(Text(history.date)),
          DataCell(Text(history.amount.toString()))
        ]);
        historyRows.add(row);
      }
   return historyRows;   


}

class CloseDisplay extends StatelessWidget{
  const CloseDisplay({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(children:[SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {
          // send info to workout view model to save workout in model
          Navigator.pop(context,);
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

class ProgressLineChart extends StatelessWidget {
  final ExerciseStats exercise;
  ProgressLineChart({super.key, required this.exercise});
  

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
              right: 30,
              left: 5,
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
          axisNameWidget: Text(switch(exercise.category){
              "Run" => "min",
              "Swim" => "sec",
              _=>"lbs"
           }),
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

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
       ListView(children: [
        HomeHeader(),
        WorkoutSchedule(),
        AchievementsList(),
        GoalTable(),


      ]),
    WorkoutOptions()
    ]));
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        color: Color.fromARGB(255, 0, 149, 255),
        padding: new EdgeInsets.all(50.0),
        child: 
        Column(
          children: [
            Row(
          children: [
            Expanded(child:Column(children: [
            Text(
              "Welcome Back",
              style: TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold),),
            Text(
              "Name" + "!",
              style: TextStyle(color: Colors.white, fontSize:24, fontWeight: FontWeight.bold),)])),
           Expanded(child:Column(children:[
            IconButtonExample(),
            Text("New Workout",
            style: TextStyle(color: Colors.white, fontSize:18 ),)
           ]))
          ],
        ),
          ]
        )
      );
  }
}

class WorkoutSchedule extends StatelessWidget {
  const WorkoutSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
      children:[
        Align( alignment: Alignment.centerLeft, child: Text("Weekly Schedule", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold))), 
        Container(color: Color.fromARGB(255, 228, 230, 231),
        child:ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: <Widget>[
    ScheduleListItem(weekday: 'Mon', workoutName: "fakeName1",),
    ScheduleListItem(weekday: 'Wed', workoutName: "fakeName2"),
    ScheduleListItem(weekday: 'Thurs', workoutName: "fakeName3",),
  ],
))
      ] ,
    ));
  }
}

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({required this.weekday, required this.workoutName});
  final String weekday;
  final String workoutName;

    @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            width:50.0,
            height: 50.0,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          child: Center(child:Text(weekday, style:TextStyle(color: Colors.white))),
          ),
          Expanded(child:Text(workoutName)),
          Container(padding: EdgeInsets.all(8.0), child:TextButton(onPressed: (){}, child: Text("View", style: TextStyle(color: Colors.black)), style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 228, 230, 231),
          ))),


          
        ],),
    );
  }
}

class AchievementsList extends StatelessWidget {
  const AchievementsList({super.key});

   @override
  Widget build(BuildContext context) {
    return Container(child: Column(children:
    [
      Align( alignment: Alignment.centerLeft, child: Text("Achievements", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold))),
      Row(children: [AchievementsListItem(), AchievementsListItem()],)
    ]));
      ListView(scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics()/*
        padding: const EdgeInsets.all(8),
        children: [
          AchievementsListItem(), AchievementsListItem()
          ]*/);


  }
}

class AchievementsListItem extends StatelessWidget {
  const AchievementsListItem({super.key});

  @override
  Widget build(BuildContext context){
    return Container( width: 100.0, child:Column(
      children:[
        Center(child:Icon(Icons.workspace_premium, color: const Color.fromARGB(255, 211, 196, 63), size: 50.0)), 
        Center(child:Text("Description here"))])
        );
  }
}
     
class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Exercise',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Goal',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Current PR',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}

class GoalTable extends StatelessWidget {
  const GoalTable({super.key});

   @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align( alignment: Alignment.centerLeft, child: Text("Goals", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold))),
      Container(width: double.infinity, child: DataTableExample()),
    ]);
  }
}

class IconButtonExample extends StatelessWidget {
  const IconButtonExample({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 0, 149, 255),
      child: Center(
        
        child: Ink(
          decoration: const ShapeDecoration(
            color: Color.fromARGB(255, 228, 230, 231),
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.add),
            iconSize: 55.0,
            color: Colors.black,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class WorkoutOptions extends StatelessWidget {
  const WorkoutOptions({super.key});
    @override
    Widget build(BuildContext context) {
      return Stack( children: [
        Container(width: double.infinity, color: Colors.black.withOpacity(0.5),), 
        Align(alignment: Alignment.bottomCenter, child: Container(height: 120, width: double.infinity, color: Colors.grey, 
        child:Column(
          children:[Expanded(child:TextButton.icon(onPressed: (){}, label: Text("Track Live", style: TextStyle(color: Colors.black, fontSize: 24)), icon: Icon(Icons.radio_button_checked, color: Colors.black, size:40,))),
        Expanded(child:TextButton.icon(onPressed: (){}, label: Text("Log Past Workout", style: TextStyle(color: Colors.black, fontSize: 24)), icon: Icon(Icons.history, color: Colors.black, size: 40))),
      ]
      )
      ))],
      );
    }

}
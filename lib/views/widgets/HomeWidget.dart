import 'package:exercise_tracking_app/models/TemplateModel.dart';
import 'package:exercise_tracking_app/models/UserModel.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/UserViewModel.dart';
import 'package:provider/provider.dart';
import 'TemplateList.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({super.key, required this.showWorkout});
  bool showWorkout;
  
  @override
  State<HomeWidget> createState() => _HomeViewState();

  
}


class _HomeViewState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    
     WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).fetchUser();
    });
  }

  void _toggleWorkout(bool change) {
    setState(() => widget.showWorkout = change);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child){
    return Scaffold(
      body: Stack(children: [
       ListView(children: [
        HomeHeader(userName: userViewModel.getUser(), update:_toggleWorkout),
        WorkoutSchedule(),
        AchievementsList(achievementsList: userViewModel.getUserAchievements()),//userViewModel.getUserAchievements()),
        GoalTable(goalsList: userViewModel.getUserGoals(),),//userViewModel.getUserGoals()),


      ]),
        WorkoutOptions(workoutVisible: widget.showWorkout, update: _toggleWorkout)
    ]));});
    }
  }


class HomeHeader extends StatelessWidget {
  final ValueChanged<bool> update;
  HomeHeader({super.key, required this.userName, required this.update});
  String userName;
  
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
            Align(alignment: Alignment.centerLeft, child:Text(
              "Welcome Back",
              style: TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold),)),
            Align(alignment: Alignment.centerLeft, child:Text(
              userName + "!",
              style: TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold),))])),
           Expanded(child:Column(children:[
            Material(
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
            onPressed: () => update(true),
          ),
        ),
      ),
    ),
            Text("New Workout",
            style: TextStyle(color: Colors.white, fontSize:18 ),)
           ]))
          ],
        ),
          ]
        )
      );}
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
          Expanded(child:Center(child:Text(workoutName))),
          Container(padding: EdgeInsets.all(8.0), child:TextButton(onPressed: (){}, child: Text("View", style: TextStyle(color: Colors.black)), style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 228, 230, 231),
          ))),


          
        ],),
    );
  }
}

class AchievementsList extends StatelessWidget {
  AchievementsList({super.key, required this.achievementsList});
  List<Achievement> achievementsList;

   @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(children:
    [
      Align( alignment: Alignment.centerLeft, child: Text("Achievements", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold))),
      Container(
                  child: SizedBox(height: 120, child:achievementsList.isNotEmpty
                    ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                        itemCount: achievementsList.length,
                        itemBuilder: (context, idx) {
                          final achievement = achievementsList[idx];
                          return AchievementsListItem(
                            date: achievement.date,
                            exerciseName: achievement.exerciseName,
                            exerciseId: achievement.exerciseId,
                            achievementThreshold: achievement.achievementThreshold,
                          );
                        }
                      )
                    : const Text('No Achievements Yet!')
                )),
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
  AchievementsListItem({super.key, required this.date, required this.exerciseName, required this.exerciseId, required this.achievementThreshold});
  DateTime date;
  String exerciseName;
  int exerciseId;
  int achievementThreshold;
  
  @override
  Widget build(BuildContext context){
    return Container( width: 100.0, child:Column(
      children:[
        Center(child:Icon(Icons.workspace_premium, size: 50, color: switch (achievementThreshold) {
          1 => const Color.fromARGB(255, 211, 196, 63),
          2 => const Color.fromARGB(255, 143, 142, 138),
          3 => const Color.fromARGB(255, 170, 128, 44),
          _ => const Color.fromARGB(255, 115, 172, 233)
        })), 
        Center(child:Text(date.month.toString() + "-" + date.day.toString())),
        Center(child:Text(switch (achievementThreshold) {
          1 => "Best",
          2 => "2nd Best",
          3 => "3rd Best",
          _ => ""
        })),
        Center(child: Text(exerciseName))])
        );
  }
}
     
class DataTableExample extends StatelessWidget {
  DataTableExample({super.key, required this.goalsList});
  List<Goal> goalsList;

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
      rows: getGoalRows(goalsList),
      
    );
  }
}

List<DataRow> getGoalRows(List<Goal> goalsList){
  List<DataRow> goalRows = <DataRow>[];
  for(Goal goal in goalsList){
        DataRow row = DataRow(cells: [
          DataCell(Text(goal.exerciseName)),
          DataCell(Text(goal.goalThreshold.toString())),
          DataCell(Text(goal.currPR.toString()))
        ]);
        goalRows.add(row);
      }
   return goalRows;   


}

class GoalTable extends StatelessWidget {
  GoalTable({super.key, required this.goalsList});
  List<Goal> goalsList;

   @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child:Column(children: [
      Align( alignment: Alignment.centerLeft, child: Text("Goals", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold))),
      Container(width: double.infinity, child: DataTableExample(goalsList: goalsList)),
    ]));
  }
}

class WorkoutOptions extends StatelessWidget {
  WorkoutOptions({super.key, required this.workoutVisible, required this.update});
  final ValueChanged<bool> update;
  bool workoutVisible;
  
    @override
    Widget build(BuildContext context) {
      return Visibility(visible: workoutVisible, child:Stack( children: [
        GestureDetector(onTap: () => update(false), child:
        Container(width: double.infinity, color: Colors.black.withOpacity(0.5),)), 
        Align(alignment: Alignment.bottomCenter, child: Container(height: 120, width: double.infinity, color: Colors.grey, 
        child:Column(
          children:[Expanded(child:TextButton.icon(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute(isLive:true)));
          }, label: Text("Track Live", style: TextStyle(color: Colors.black, fontSize: 24)), icon: Icon(Icons.radio_button_checked, color: Colors.black, size:40,))),
        Expanded(child:TextButton.icon(onPressed: (){
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute(isLive:false)));
          }
        , label: Text("Log Past Workout", style: TextStyle(color: Colors.black, fontSize: 24)), icon: Icon(Icons.history, color: Colors.black, size: 40))),
      ]
      )
      ))],
      ));
    }

}

class SecondRoute extends StatelessWidget {
  SecondRoute({super.key, required this.isLive});
  bool isLive;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Workout Template'),
      ),
      body: Center(
        child: TemplateList(isWorkout: true, chooseTemplate: (Template? template) {
            //SEND SHIT TO WORKOUT VIEW
          })
        
      ),
    );
  }
  
}
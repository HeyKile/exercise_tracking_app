import 'package:exercise_tracking_app/models/UserModel.dart';
import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:exercise_tracking_app/viewmodels/WorkoutViewModel.dart';
import 'package:exercise_tracking_app/views/widgets/WorkoutSummary.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/UserViewModel.dart';
import 'package:provider/provider.dart';

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
      Provider.of<WorkoutViewModel>(context, listen: false).loadWorkouts();

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
        const WorkoutSchedule(),
        AchievementsList(achievementsList: userViewModel.getUserAchievements()),//userViewModel.getUserAchievements()),
        GoalTable(goalsList: userViewModel.getUserGoals(),),//userViewModel.getUserGoals()),


      ]),
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
        color: const Color.fromARGB(255, 0, 149, 255),
        padding: const EdgeInsets.all(50.0),
        child: 
        Column(
          children: [
            Row(
          children: [
            Expanded(child:Column(children: [
            const Align(alignment: Alignment.center, child:Text(
              "Welcome Back",
              style: TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold),)),
            Align(alignment: Alignment.center, child:Text(
              "$userName!",
              style: const TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold),))])),
           
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
      children:[
        const Align( alignment: Alignment.centerLeft, child: Text("Weekly Summary", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold))), 
        Container(color: const Color.fromARGB(255, 228, 230, 231),
        child:ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: getWeeklyWorkouts(),
     /* for workout in getWeeklyWorkouts(){
        <Widget>[
    ScheduleListItem(weekday: 'Mon', workoutName: "Morning Run",),
    ScheduleListItem(weekday: 'Wed', workoutName: "Lower Body Lift"),
    ScheduleListItem(weekday: 'Thurs', workoutName: "HIIT Workout",),
  ],*/
))
      ] ,
    ));
  }
}

List<ScheduleListItem> getWeeklyWorkouts(){
  List<ScheduleListItem> weeklyWorkouts = <ScheduleListItem>[];
  WorkoutViewModel workoutViewModel = WorkoutViewModel();
  workoutViewModel.loadWorkouts();
  List dayData =
      ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun" ];
  DateTime weekStart = DateTime.parse('2024-12-01T00:00:00');
  DateTime weekEnd = DateTime.parse("2024-12-07T00:00:00");
  for(Workout workout in workoutViewModel.allWorkouts){
    if (workout.date.isAfter(weekStart) && workout.date.isBefore(weekEnd)){
      weeklyWorkouts.add(ScheduleListItem(weekday: dayData[workout.date.weekday-1], workoutName: workout.workoutName, workout: workout, workoutViewModel: workoutViewModel));
    }
  }

  return weeklyWorkouts;
}

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({super.key, required this.weekday, required this.workoutName, required this.workout, required this.workoutViewModel});
  final String weekday;
  final String workoutName;
  final Workout workout;
  final WorkoutViewModel workoutViewModel;

    @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            width:50.0,
            height: 50.0,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          child: Center(child:Text(weekday, style:const TextStyle(color: Colors.white))),
          ),
          Expanded(child:Center(child:Text(workoutName))),
          Container(padding: const EdgeInsets.all(8.0), child:TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutSummary(workoutViewModel: workoutViewModel, currentWorkout: workout),
              )
            );
          }, style: TextButton.styleFrom(
            backgroundColor:const Color.fromARGB(255, 228, 230, 231),
          ), child: const Text("View", style: TextStyle(color: Colors.black)))),


          
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
      padding: const EdgeInsets.all(8.0),
      child: Column(children:
    [
      const Align( alignment: Alignment.centerLeft, child: Text("Achievements", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold))),
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
     
class GoalDataTable extends StatelessWidget {
  GoalDataTable({super.key, required this.goalsList});
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
      Container(width: double.infinity, child: GoalDataTable(goalsList: goalsList)),
    ]));
  }
}


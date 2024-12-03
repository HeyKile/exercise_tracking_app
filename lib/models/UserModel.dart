class User {
  String name;
  List<Achievement> achievements;
  List<Goal> goals;

  User({
    required this.name, 
    required this.achievements, 
    required this.goals
    
    });
}

class Achievement {
  DateTime date;
  String exerciseName;
  int exerciseId;
  int achievementThreshold;

  Achievement({ required this.date, required this.exerciseName, required this.exerciseId, required this.achievementThreshold});

}

class Goal {
  String exerciseName;
  int exerciseId;
  int goalThreshold;
  int currPR;

  Goal({required this.exerciseName, required this.exerciseId, required this.goalThreshold, required this.currPR,});
}
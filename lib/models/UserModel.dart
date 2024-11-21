class User {
  String name;
  List<Achievement> achievements;
  List<Goal> goals;

  User({
    required this.name, 
    required this.achievements, 
    required this.goals
    
    });

  factory User.fromJson(Map<String, dynamic> json) {
    var achievementsJson = json['achievements'] as List;
    List<Achievement> achievementsList = achievementsJson.map((achievementsJson) => Achievement.fromJson(achievementsJson)).toList();
    var goalsJson = json['goals'] as List;
    List<Goal> goalsList = goalsJson.map((goalsJson) => Goal.fromJson(goalsJson)).toList();
    return User(
      name: json['name'],
      goals: goalsList,
      achievements: achievementsList,
    );
  }
}

class Achievement {
  DateTime date;
  String exerciseName;
  int exerciseId;
  int achievementThreshold;

  Achievement({ required this.date, required this.exerciseName, required this.exerciseId, required this.achievementThreshold});

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      date: DateTime.parse(json['date']),
      exerciseName: json['exerciseName'],
      exerciseId: json['exerciseId'],
      achievementThreshold: json['achievementThreshold'],
    );
  }

}

class Goal {
  String exerciseName;
  int exerciseId;
  int goalThreshold;
  int currPR;

  Goal({required this.exerciseName, required this.exerciseId, required this.goalThreshold, required this.currPR,});

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      exerciseName: json['exerciseName'],
      exerciseId: json['exerciseId'],
      goalThreshold: json['goalThreshold'],
      currPR: json['currPR'],
    );
  }
}
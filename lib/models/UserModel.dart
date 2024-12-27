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

class UserPrime {
  int id;
  String username;
  String pwdHash;
  String firstName;
  String lastName;
  DateTime birthday;
  DateTime creationDate;
  bool isAdmin;

  UserPrime({
    required this.id,
    required this.username,
    required this.pwdHash,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.creationDate,
    required this.isAdmin,
  });

  factory UserPrime.fromJson(Map<String, dynamic> json) {
    return UserPrime(
      id: json['id'],
      username: json['username'],
      pwdHash: json['pwdHash'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthday: DateTime.parse(json['birthday']),
      creationDate: DateTime.parse(json['creationDate']),
      isAdmin: json['isAdmin'],
    );
  }
}

class AchievementPrime {
  
}
import '../models/UserModel.dart';

class UserService {
  List<User> createMockUsers() {
    return [
      User(
        name: "Pete",
        achievements: [
          Achievement(
            date: DateTime.parse("2024-10-31"),
            exerciseName: "Squat",
            exerciseId: 1,
            achievementThreshold: 1,
          ),
          Achievement(
            date: DateTime.parse("2024-10-06"),
            exerciseName: "1 mile",
            exerciseId: 2,
            achievementThreshold: 3,
          ),
          Achievement(
            date: DateTime.parse("2024-09-25"),
            exerciseName: "Bench Press",
            exerciseId: 3,
            achievementThreshold: 2,
          ),
        ],
        goals: [
          Goal(
            exerciseName: "Bench Press",
            exerciseId: 3,
            goalThreshold: 100,
            currPR: 80,
          ),
          Goal(
            exerciseName: "Deadlift",
            exerciseId: 4,
            goalThreshold: 215,
            currPR: 200,
          ),
          Goal(
            exerciseName: "Hammer Curls",
            exerciseId: 5,
            goalThreshold: 45,
            currPR: 20,
          ),
          Goal(
            exerciseName: "Squat",
            exerciseId: 1,
            goalThreshold: 205,
            currPR: 200,
          ),
        ],
      ),
    ];
  }

}
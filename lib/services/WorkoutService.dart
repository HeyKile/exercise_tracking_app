import '../models/WorkoutModel.dart';

class WorkoutService {

  List<Workout> createMockWorkouts() {
    return [
      Workout(
        id: "f882cc45-aaf1-4025-9b5d-87d2a29911e3",
        completed: [
          WorkoutExercise(
            name: "Leg Press",
            sets: [
              Set(
                reps: 12,
                weight: 1020,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 10,
                weight: 110,
                time: -1,
                distance: -1,
                unit: "lbs"
              )
            ],
            notes: ""
          )
        ],
        time: "00:00:00",
        workoutName: "Cool Workout",
        date: DateTime.parse("2024-11-21T11:21:40.980995"),
        intensity: 0,
        tags: []
      ),
    ];
  }
}

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
                weight: 1020
              ),
              Set(
                reps: 10,
                weight: 110
              )
            ],
            notes: ""
          )
        ],
        time: "00:00:00",
        workoutName: "Cool Workout",
        date: DateTime.parse("2024-11-02T10:21:00"),
        intensity: 0,
        tags: []
      ),
      Workout(
        id: "f882cc45-aaf1-4025-9b5d-87d2a29911e4",
        completed: [
          WorkoutExercise(
            name: "Leg Press",
            sets: [
              Set(
                reps: 12,
                weight: 120
              ),
              Set(
                reps: 10,
                weight: 110
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Squats",
            sets: [
              Set(
                reps: 12,
                weight: 130
              ),
              Set(
                reps: 10,
                weight: 120
              ),
              Set(
                reps: 8,
                weight: 110
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Calf Raises",
            sets: [
              Set(
                reps: 10,
                weight: 80
              ),
              Set(
                reps: 10,
                weight: 80
              ),
              Set(
                reps: 8,
                weight: 80
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Bulgarian Split Squat",
            sets: [
              Set(
                reps: 10,
                weight: 30
              ),
              Set(
                reps: 10,
                weight: 30
              ),
            ],
            notes: ""
          )
        ],
        time: "00:41:23",
        workoutName: "Lower Body Lift",
        date: DateTime.parse("2024-12-03T03:21:00"),
        intensity: 1,
        tags: []
      ),
            Workout(
        id: "f882cc45-aaf1-4025-9b5d-87d2a29911e5",
        completed: [
          WorkoutExercise(
            name: "Dumbell Rows",
            sets: [
              Set(
                reps: 12,
                weight: 30
              ),
              Set(
                reps: 10,
                weight: 30
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Jump Squats",
            sets: [
              Set(
                reps: 12,
                weight: 10
              ),
              Set(
                reps: 12,
                weight: 10
              ),
              Set(
                reps: 12,
                weight: 10
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Calf Raises",
            sets: [
              Set(
                reps: 10,
                weight: 80
              ),
              Set(
                reps: 10,
                weight: 80
              ),
              Set(
                reps: 8,
                weight: 80
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Russian Twists",
            sets: [
              Set(
                reps: 20,
                weight: 30
              ),
              Set(
                reps: 20,
                weight: 30
              ),
            ],
            notes: "These were hard."
          )
        ],
        time: "00:30:06",
        workoutName: "Morning HIIT Workout",
        date: DateTime.parse("2024-12-05T09:46:00"),
        intensity: 2,
        tags: []
      ),
    ];
  }
}

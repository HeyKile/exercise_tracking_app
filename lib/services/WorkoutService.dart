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
                weight: 120,
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
          ),
          WorkoutExercise(
            name: "Squats",
            sets: [
              Set(
                reps: 12,
                weight: 130,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 10,
                weight: 120,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 8,
                weight: 110,
                time: -1,
                distance: -1,
                unit: "lbs"
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Calf Raises",
            sets: [
              Set(
                reps: 10,
                weight: 80,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 10,
                weight: 80,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 8,
                weight: 80,
                time: -1,
                distance: -1,
                unit: "lbs"
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Bulgarian Split Squat",
            sets: [
              Set(
                reps: 10,
                weight: 30,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 10,
                weight: 30,
                time: -1,
                distance: -1,
                unit: "lbs"
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
                weight: 30,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 10,
                weight: 30,
                time: -1,
                distance: -1,
                unit: "lbs"
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Jump Squats",
            sets: [
              Set(
                reps: 12,
                weight: 10,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 12,
                weight: 10,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 12,
                weight: 10,
                time: -1,
                distance: -1,
                unit: "lbs"
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Calf Raises",
            sets: [
              Set(
                reps: 10,
                weight: 80,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 10,
                weight: 80,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 8,
                weight: 80,
                time: -1,
                distance: -1,
                unit: "lbs"
              )
            ],
            notes: ""
          ),
          WorkoutExercise(
            name: "Russian Twists",
            sets: [
              Set(
                reps: 20,
                weight: 30,
                time: -1,
                distance: -1,
                unit: "lbs"
              ),
              Set(
                reps: 20,
                weight: 30,
                time: -1,
                distance: -1,
                unit: "lbs"
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

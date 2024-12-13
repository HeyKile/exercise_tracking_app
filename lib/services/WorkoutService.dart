import 'package:exercise_tracking_app/models/ExerciseModel.dart';

import '../models/WorkoutModel.dart';

class WorkoutService {

  List<Workout> createMockWorkouts() {
    return [
      Workout(
        id: "f882cc45-aaf1-4025-9b5d-87d2a29911e3",
        completed: [
          Exercise(
            id: 15,
            name: "Leg Press",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 135, "reps": 10},
            ],
            notes: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            unit: "lbs",
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
          Exercise(
            id: 15,
            name: "Leg Press",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 135, "reps": 10},
            ],
            notes: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            unit: "lbs",
          ),
          Exercise(
            id: 0,
            name: "Squats",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 135, "reps": 10},
            ],
            notes: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            unit: "lbs",
          ),
          Exercise(
            id: 31, 
            name: "Calf Raises",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 135, "reps": 10},
            ],
            notes: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            unit: "lbs",
          ),
          Exercise(
            id: 34,
            name: "Bulgarian Split Squat",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 135, "reps": 10},
            ],
            notes: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            unit: "lbs",
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
          Exercise(
            id: 33,
            name: "Dumbell Rows",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 135, "reps": 10},
            ],
            notes: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            unit: "lbs",
          ),
          Exercise(
            id: 32,
            name: "Jump Squats",
            sets: [
              
            ],
            notes: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: false,
            unit: "",
          ),
          Exercise(
            id: 30,
            name: "Calf Raises",
            sets: [
              
            ],
            notes: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            unit: "lbs",
          ),
          Exercise(
            id: 31,
            name: "Russian Twists",
            sets: [
              
            ],
            trackedStats: [
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            unit: "lbs",
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

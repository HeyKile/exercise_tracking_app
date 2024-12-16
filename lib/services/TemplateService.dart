import 'package:exercise_tracking_app/models/ExerciseModel.dart';

import '../models/TemplateModel.dart';

class TemplateService {
  Future<List<Template>> createMockTemplates() async {
    return <Template>[
      Template(
        id: 0,
        name: "Leg Day",
        isPremade: false,
        exercises: [
          Exercise(
            id: 0,
            name: "Barbell Squat",
            sets: [
              {"weight": 180, "reps": 12},
              {"weight": 200, "reps": 8}
            ],

            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            notes: ""
          ),
          Exercise(
            id: 3,
            name: "Deadlift",
            sets: [
              {"weight": 225, "reps": 8},
              {"weight": 255, "reps": 6},
              {"weight": 280, "reps": 3},
              {"weight": 315, "reps": 3}
            ],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
        ],
      ),
      Template(
        id: 1,
        name: "Push Day",
        isPremade: false,
        exercises: [
          Exercise(
            id: 1,
            name: "Barbell Bench Press",
            sets: [],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
          Exercise(
            id: 5,
            name: "Dumbbell Shoulder Press",
            sets: [],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
          Exercise(
            id: 24,
            name: "Dumbbell Fly",
            sets: [],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
        ],
      ),
      Template(
        id: 2,
        name: "Intense Run",
        isPremade: true,
        exercises: [
          Exercise(
            id: 2,
            name: "Run",
            sets: [
              {"Distance": 1, "Time": 10,},
              {"Distance": 3, "Time": 25},
              {"Distance": 2, "Time": 16},
              {"Distance": 1, "Time": 10},
            ],
            distanceUnit: "mi",
            weightUnit: "",
            timeUnit: "mins",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.distance, display: "Distance", unit: "mi"),
              const ExerciseStat(type: TrackableStat.time, display: "Time", unit: "mins"),
            ],
            isCustom: false,
            hasDistance: true,
            hasReps: false,
            hasTime: true,
            hasWeight: false,
            notes: "",
          )
        ]
      ),
      Template(
        id: 3,
        name: "Full Body Workout",
        isPremade: true,
        exercises: [
          Exercise(
            id: 9,
            name: "Dumbbell Curl",
            sets: [
              {"weight": 10, "reps": 12},
              {"weight": 15, "reps": 10},
            ],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
          Exercise(
            id: 13,
            name: "Lat Pulldown",
            sets: [
              {"weight": 50, "reps": 12},
              {"weight": 60, "reps": 10},
            ],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
          Exercise(
            id: 15,
            name: "Leg Press",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 145, "reps": 8},
            ],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
          Exercise(
            id: 1,
            name: "Barbell Bench Press",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 135, "reps": 10},
            ],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
          Exercise(
            id: 5,
            name: "Dumbbell Shoulder Press",
            sets: [
              {"weight": 30, "reps": 12},
              {"weight": 40, "reps": 8},
            ],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
        ]
      ),
      Template(
        id: 4,
        name: "Push Day 2",
        isPremade: false,
        icon: TemplateIcon.dumbbell,
        exercises: [
          Exercise(
            id: 1,
            name: "Barbell Bench Press",
            sets: [],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
          Exercise(
            id: 5,
            name: "Dumbbell Shoulder Press",
            sets: [],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
          Exercise(
            id: 24,
            name: "Dumbbell Fly",
            sets: [],
            distanceUnit: "",
            weightUnit: "lbs",
            timeUnit: "",
            trackedStats: [
              const ExerciseStat(type: TrackableStat.weight, display: "Weight", unit: "lbs"),
              const ExerciseStat(type: TrackableStat.reps, display: "Reps"),
            ],
            isCustom: false,
            hasDistance: false,
            hasReps: true,
            hasTime: false,
            hasWeight: true,
            notes: ""
          ),
        ],
      ),
    ];
  }
}
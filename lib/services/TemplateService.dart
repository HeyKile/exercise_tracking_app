import '../models/TemplateModel.dart';

class TemplateService {
  Future<List<Template>> createMockTemplates() async {
    return <Template>[
      Template(
        id: 0,
        name: "Leg Day",
        isPremade: false,
        exercises: [
          TemplateExercise(
            id: 0,
            name: "Barbell Squat",
            sets: [
              {"weight": 180, "reps": 12},
              {"weight": 200, "reps": 8}
            ],
          ),
          TemplateExercise(
            id: 3,
            name: "Deadlift",
            sets: [
              {"weight": 225, "reps": 8},
              {"weight": 255, "reps": 6},
              {"weight": 280, "reps": 3},
              {"weight": 315, "reps": 3}
            ],
          ),
        ],
      ),
      Template(
        id: 1,
        name: "Push Day",
        isPremade: false,
        exercises: [
          TemplateExercise(
            id: 1,
            name: "Barbell Bench Press",
            sets: [],
          ),
          TemplateExercise(
            id: 5,
            name: "Dumbbell Shoulder Press",
            sets: [],
          ),
          TemplateExercise(
            id: 24,
            name: "Dumbbell Fly",
            sets: [],
          ),
        ],
      ),
      Template(
        id: 2,
        name: "Intense Run",
        isPremade: true,
        exercises: [
          TemplateExercise(
            id: 2,
            name: "Run",
            sets: [
              {"Distance": 1, "Time": 10},
              {"Distance": 3, "Time": 25},
              {"Distance": 2, "Time": 16},
              {"Distance": 1, "Time": 10},
            ]
          )
        ]
      ),
      Template(
        id: 3,
        name: "Full Body Workout",
        isPremade: true,
        exercises: [
          TemplateExercise(
            id: 9,
            name: "Dumbbell Curl",
            sets: [
              {"weight": 10, "reps": 12},
              {"weight": 15, "reps": 10},
            ]
          ),
          TemplateExercise(
            id: 13,
            name: "Lat Pulldown",
            sets: [
              {"weight": 50, "reps": 12},
              {"weight": 60, "reps": 10},
            ]
          ),
          TemplateExercise(
            id: 15,
            name: "Leg Press",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 145, "reps": 8},
            ]
          ),
          TemplateExercise(
            id: 1,
            name: "Barbell Bench Press",
            sets: [
              {"weight": 120, "reps": 12},
              {"weight": 135, "reps": 10},
            ]
          ),
          TemplateExercise(
            id: 5,
            name: "Dumbbell Shoulder Press",
            sets: [
              {"weight": 30, "reps": 12},
              {"weight": 40, "reps": 8},
            ]
          ),
        ]
      ),
      Template(
        id: 4,
        name: "Push Day 2",
        isPremade: false,
        icon: TemplateIcon.dumbbell,
        exercises: [
          TemplateExercise(
            id: 1,
            name: "Barbell Bench Press",
            sets: [],
          ),
          TemplateExercise(
            id: 5,
            name: "Dumbbell Shoulder Press",
            sets: [],
          ),
          TemplateExercise(
            id: 24,
            name: "Dumbbell Fly",
            sets: [],
          ),
        ],
      ),
    ];
  }
}
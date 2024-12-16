class Exercise {
  final int id;
  final String name;
  final List<ExerciseStat> trackedStats;
  final bool isCustom;
  final bool hasReps;
  final bool hasDistance;
  final bool hasWeight;
  final bool hasTime;
  final List<dynamic> sets;
  String timeUnit;
  String distanceUnit;
  String weightUnit;
  String notes;

  Exercise({
    required this.id,
    required this.name,
    required this.trackedStats,
    required this.isCustom,
    required this.hasReps,
    required this.hasDistance,
    required this.hasTime,
    required this.hasWeight,
    required this.notes,
    required this.sets,
    required this.timeUnit,
    required this.distanceUnit,
    required this.weightUnit,
  });

  factory Exercise.fromInput(String name, bool hasDistance, bool hasRep, bool hasWeight, bool hasTime) {
    List<ExerciseStat> statsToTrack = [];
    String distanceUnit = "";
    String timeUnit = "";
    String weightUnit = "";
    if (hasDistance) {
      statsToTrack.add(
        const ExerciseStat(
          type: TrackableStat.distance,
          display: "Distance",
          unit: "mi"
        )
      );
      distanceUnit = "mi";
    }
    if (hasRep) {
      statsToTrack.add(
        const ExerciseStat(
          type: TrackableStat.reps,
          display: "Reps",
        )
      );
    }
    if (hasWeight) {
      statsToTrack.add(
        const ExerciseStat(
          type: TrackableStat.weight,
          display: "Weight",
          unit: "lbs"
        )
      );
      weightUnit = "lbs";
    }
    if (hasTime) {
      statsToTrack.add(
        const ExerciseStat(
          type: TrackableStat.time,
          display: "Time",
          unit: "mins"
        )
      );
      timeUnit = "mins";
    }
    return Exercise(
      id: -1,
      name: name,
      trackedStats: statsToTrack,
      isCustom: true,
      hasDistance: hasDistance,
      hasReps: hasRep,
      hasTime: hasTime,
      hasWeight: hasWeight,
      notes: "",
      distanceUnit: distanceUnit,
      weightUnit: weightUnit,
      timeUnit: timeUnit,
      sets: List.empty(),
    );
  }
}

enum TrackableStat { 
  weight,
  reps,
  time,
  distance
}

class ExerciseStat {
  final TrackableStat type;
  final String display;
  final String? unit;

  const ExerciseStat({
    required this.type,
    required this.display,
    this.unit
  });
}
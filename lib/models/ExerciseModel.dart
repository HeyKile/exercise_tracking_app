class Exercise {
  final int id;
  final String name;
  final List<ExerciseStat> trackedStats;
  final bool isCustom;

  Exercise({
    required this.id,
    required this.name,
    required this.trackedStats,
    required this.isCustom
  });

  factory Exercise.fromInput(String name, bool hasDistance, bool hasRep, bool hasWeight, bool hasTime) {
    List<ExerciseStat> statsToTrack = [];
    if (hasDistance) {
      statsToTrack.add(
        const ExerciseStat(
          type: TrackableStat.distance,
          display: "Distance",
          unit: "mi"
        )
      );
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
    }
    if (hasTime) {
      statsToTrack.add(
        const ExerciseStat(
          type: TrackableStat.time,
          display: "Time",
          unit: "mins"
        )
      );
    }
    return Exercise(
      id: -1,
      name: name,
      trackedStats: statsToTrack,
      isCustom: true
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
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

  factory Exercise.fromJson(Map<String, dynamic> json) {
    var trackedStatsJson = json['trackedStats'] as List;
    List<ExerciseStat> statsList = trackedStatsJson.map((stat) => ExerciseStat.fromJson(stat)).toList();
    return Exercise(
      id: json['id'],
      name: json['name'],
      trackedStats: statsList,
      isCustom: json['isCustom'] ?? false,
    );
  }

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

  factory ExerciseStat.fromJson(Map<String, dynamic> json) {
    switch(json['type']) {
      case "Weight":
        return ExerciseStat(
          type: TrackableStat.weight,
          display: json['type'],
          unit: json['unit']
        );
      case "Reps":
        return ExerciseStat(
          type: TrackableStat.reps,
          display: json['type'],
        );
      case "Time":
        return ExerciseStat(
          type: TrackableStat.time,
          display: json['type'],
          unit: json['unit']
        );
      case "Distance":
        return ExerciseStat(
          type: TrackableStat.distance,
          display: json['type'],
          unit: json['unit']
        );
      default:
        throw Exception('Unknown TrackableStat type: ${json['type']}'); 
    } 
  }

}
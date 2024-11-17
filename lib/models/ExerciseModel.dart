class Exercise {
  final int id;
  final String name;
  final List<ExerciseStat> trackedStats;

  Exercise({
    required this.id,
    required this.name,
    required this.trackedStats
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    var trackedStatsJson = json['trackedStats'] as List;
    List<ExerciseStat> statsList = trackedStatsJson.map((stat) => ExerciseStat.fromJson(stat)).toList();
    return Exercise(
      id: json['id'],
      name: json['name'],
      trackedStats: statsList
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
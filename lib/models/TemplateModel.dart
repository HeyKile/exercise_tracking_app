class Template {
  final int id;
  final String name;
  final bool isPremade;
  final List<TemplateExercise> exercises;

  Template({
    required this.id,
    required this.name,
    required this.isPremade,
    required this.exercises
  });

  factory Template.fromJson(Map<String, dynamic> json) {
    var exercisesJson = json['exercises'] as List;
    List<TemplateExercise> exercisesList = exercisesJson.map((exerciseJson) => TemplateExercise.fromJson(exerciseJson)).toList();
    return Template(
      id: json['id'],
      name: json['name'],
      isPremade: json['isPremade'],
      exercises: exercisesList,
    );
  }
}

// temporary class until Exercise model is finished?
class TemplateExercise {
  final int id;
  final String name;
  final List<dynamic> sets;

  TemplateExercise({required this.id, required this.name, required this.sets});

  factory TemplateExercise.fromJson(Map<String, dynamic> json) {
    return TemplateExercise(
      id: json['id'],
      name: json['name'],
      sets: json['sets'],
    );
  }
}
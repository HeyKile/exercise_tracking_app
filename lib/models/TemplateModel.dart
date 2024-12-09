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
}

// temporary class until Exercise model is finished?
class TemplateExercise {
  final int id;
  final String name;
  final List<dynamic> sets;
  final String unit;

  TemplateExercise({
    required this.id,
    required this.name,
    required this.sets,
    required this.unit
  });
}
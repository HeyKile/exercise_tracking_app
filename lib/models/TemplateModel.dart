import 'package:flutter/material.dart';

class Template {
  final int id;
  final String name;
  final bool isPremade;
  final List<TemplateExercise> exercises;
  final TemplateIcon icon;

  Template({
    required this.id,
    required this.name,
    required this.isPremade,
    required this.exercises,
    this.icon = TemplateIcon.person,
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

enum TemplateIcon {
  person, // accessibility_new
  bike, // directions_bike
  run, // directions_run
  dumbbell, // fitness_center
  hiking, // hiking
  swimming, // pool
  glove, // sports_mma
  rugby, // sports_rugby
  soccer, // sports_soccer
  tennis, // sports_tennis
  volleyballl, // sports_volleyball
}

extension TemplateIconExtension on TemplateIcon {
  IconData getIcon() {
    switch (this) {
      case TemplateIcon.person:
        return Icons.accessibility_new;
      case TemplateIcon.bike:
        return Icons.directions_bike;
      case TemplateIcon.run:
        return Icons.directions_run;
      case TemplateIcon.dumbbell:
        return Icons.fitness_center;
      case TemplateIcon.hiking:
        return Icons.hiking;
      case TemplateIcon.swimming:
        return Icons.pool;
      case TemplateIcon.glove:
        return Icons.sports_mma;
      case TemplateIcon.rugby:
        return Icons.sports_rugby;
      case TemplateIcon.soccer:
        return Icons.sports_soccer;
      case TemplateIcon.tennis:
        return Icons.sports_tennis;
      case TemplateIcon.volleyballl:
        return Icons.sports_volleyball;
    }
  }
}
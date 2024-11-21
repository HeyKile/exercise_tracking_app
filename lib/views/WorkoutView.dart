import 'package:flutter/material.dart';
import 'package:exercise_tracking_app/views/widgets/LiveWorkout.dart';
import 'package:exercise_tracking_app/views/widgets/PastWorkout.dart';
import '../../models/TemplateModel.dart';


class WorkoutView extends StatelessWidget {
  final bool isLive;
  final Template? template; // could also be null.

  const WorkoutView({super.key, required this.isLive, required this.template});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLive ? LiveWorkout(template: template) : PastWorkout(template: template),
    );
  }
}
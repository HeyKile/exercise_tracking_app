import 'package:flutter/material.dart';
import 'package:exercise_tracking_app/views/widgets/LiveWorkout.dart';
import 'package:exercise_tracking_app/views/widgets/PastWorkout.dart';

class WorkoutView extends StatelessWidget {
  final bool isLive;

  const WorkoutView({super.key, required this.isLive});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLive ? const LiveWorkout() : const PastWorkout(),
    );
  }
}
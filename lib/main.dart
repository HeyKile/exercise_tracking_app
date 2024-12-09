import 'package:exercise_tracking_app/viewmodels/StatsViewModel.dart';
import 'package:exercise_tracking_app/viewmodels/WorkoutViewModel.dart';
import 'package:exercise_tracking_app/views/MainView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/ExerciseViewModel.dart';
import 'viewmodels/TemplateViewModel.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TemplateViewModel()),
        ChangeNotifierProvider(create: (context) => ExerciseViewModel()),
        ChangeNotifierProvider(create: (context) => WorkoutViewModel()),
        ChangeNotifierProvider(create: (context) => StatsViewModel()),
      ],
      child: MaterialApp(
        home: MainView(),
      ),
    );
  }
}

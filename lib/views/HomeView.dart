import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/UserViewModel.dart';
import 'package:exercise_tracking_app/viewmodels/WorkoutViewModel.dart';
import 'widgets/HomeWidget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key, required this.showWorkout});
  bool showWorkout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => WorkoutViewModel()),
      ],
        child: HomeWidget(showWorkout: showWorkout,),
        ),
      ),
    );
  }
}
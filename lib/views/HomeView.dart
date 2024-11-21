import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/UserViewModel.dart';
import 'widgets/HomeWidget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key, required this.showWorkout});
  bool showWorkout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: ChangeNotifierProvider(
          create: (_) => UserViewModel(),
          child: HomeWidget(showWorkout: showWorkout,),
        ),
      ),
    );
  }
}
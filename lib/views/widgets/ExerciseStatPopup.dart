import 'package:exercise_tracking_app/models/ExerciseModel.dart';

import '../../viewmodels/StatsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exercise_tracking_app/views/MainView.dart';


class ExerciseStatPopup extends StatefulWidget{
  final ExerciseStats exercise;
  const ExerciseStatPopup({super.key, required this.exercise});

  @override
  State<ExerciseStatPopup> createState() => _ExerciseStatPopupState();

}

class _ExerciseStatPopupState extends State<ExerciseStatPopup>{
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: CloseDisplay()
    );
}}


class CloseDisplay extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {
          // send info to workout view model to save workout in model
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainView(selectedIndex: 3),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          backgroundColor: const Color.fromRGBO(144, 238, 144, 1),
          padding: const EdgeInsets.all(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Close Display',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              )
            )
          ],
        ),
      ),
    );
  }
}


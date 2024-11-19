import 'package:exercise_tracking_app/viewmodels/WorkoutViewModel.dart';
import 'package:exercise_tracking_app/views/MainView.dart';
import 'package:exercise_tracking_app/views/StatsView.dart';
import 'package:exercise_tracking_app/views/widgets/ExerciseTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/WorkoutModel.dart';

class WorkoutSummary extends StatefulWidget{
  final Workout? currentWorkout;
  final WorkoutViewModel workoutViewModel;
  const WorkoutSummary({super.key, required this.currentWorkout, required this.workoutViewModel});

  @override
  _WorkoutSummaryState createState() => _WorkoutSummaryState();

}

class _WorkoutSummaryState extends State<WorkoutSummary>{
  int selectedIntensity = 0;

  @override
  void initState() { 
    super.initState(); 
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      Provider.of<WorkoutViewModel>(context, listen: false).loadWorkouts(); 
    }); 
  }
  

  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: Consumer<WorkoutViewModel>( 
        builder: (context, workoutViewModel, child) { 
          final exercises = widget.currentWorkout?.completed ?? [];
          print('Current exercises: $exercises'); 
          return SingleChildScrollView( 
            child: Column( 
              children: [ 
                Container( 
                  padding: const EdgeInsets.symmetric(vertical: 16.0), 
                  decoration: const BoxDecoration( color: Colors.blue, ), 
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [ 
                      const SizedBox(width: 16.0),
                      WorkoutHeader(workout: widget.currentWorkout), 
                      const TagButton(),
                      const SizedBox(height: 16.0), 
                    ], 
                  ), 
                ), 
                const SizedBox(height: 16.0), 
                for (int i = 0; i < exercises.length; i++) 
                ExerciseTile( exercise: exercises[i], isEditable: false, onDeleteExercise: () {}, onSetDetailsChanged: (int setIndex, int reps, int weight) {}, ), 
                const SizedBox(height: 15), 
                Intensity(onIntensityChanged: (int intensity){
                  setState(() {
                    selectedIntensity = intensity;
                  });
                }), 
                const SizedBox(height: 16.0), 
                CloseDisplay(selectedIntensity: selectedIntensity, workoutViewModel: workoutViewModel, currentWorkout: widget.currentWorkout), 
                const SizedBox(height: 16.0), 
              ], 
            ), 
          ); 
        }, 
      ), 
    );
  }
}

class Intensity extends StatefulWidget {
  final ValueChanged<int> onIntensityChanged;
  const Intensity({super.key, required this.onIntensityChanged});

  @override
  // ignore: library_private_types_in_public_api
  _IntensityState createState() => _IntensityState();
}

class _IntensityState extends State<Intensity> {
  int selectedIntensity = 0;

  void _incrementIntensity() {
    setState(() {
      selectedIntensity = (selectedIntensity + 1).clamp(1, 10);
      widget.onIntensityChanged(selectedIntensity);
    });
  }

  void _decrementIntensity() {
    setState(() {
      selectedIntensity = (selectedIntensity - 1).clamp(1, 10);
      widget.onIntensityChanged(selectedIntensity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.blue, 

        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            IconButton(
            icon: const Icon(Icons.arrow_upward, size: 30, color: Colors.black),
            onPressed: _incrementIntensity,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward, size: 30, color: Colors.black),
              onPressed: _decrementIntensity,
            ),
            Text(
            selectedIntensity.toString(), 
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
          ),
          const Text(
            'Intensity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CloseDisplay extends StatelessWidget{
  final int selectedIntensity;
  final WorkoutViewModel workoutViewModel;
  final Workout? currentWorkout;
  const CloseDisplay({super.key, required this.selectedIntensity, required this.workoutViewModel, required this.currentWorkout});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {
          // send info to workout view model to save workout in model
          workoutViewModel.updateIntensity(selectedIntensity, currentWorkout);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainView(),
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
                color: Colors.white,
                fontSize: 10,
              )
            )
          ],
        ),
      ),
    );
  }
}

class TagButton extends StatelessWidget{
  const TagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.05,
      child: ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
      ),
      child:  const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.tag_outlined,
            size: 10, 
            color: Colors.black, 
          ),
          Text('Tags', style: TextStyle(color: Colors.black),),
        ],
      ),
      ),
    );
  }
}

class WorkoutHeader extends StatelessWidget{
  final Workout? workout;
  const WorkoutHeader({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: Colors.blue, 
      ),
      child: Align(
        alignment: Alignment.topLeft, 
        child: Text(
          workout!.workoutName,
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

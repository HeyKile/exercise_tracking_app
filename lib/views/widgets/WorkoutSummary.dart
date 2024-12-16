import 'package:exercise_tracking_app/viewmodels/WorkoutViewModel.dart';
import 'package:exercise_tracking_app/views/MainView.dart';
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
      Provider.of<WorkoutViewModel>(context, listen: false).loadWorkouts(); // we get the exercises from the provider
    }); 
  }
  

  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: Consumer<WorkoutViewModel>( 
        builder: (context, workoutViewModel, child) { 
          final exercises = widget.currentWorkout?.completed ?? []; // and we set them equal to the list here
          return SingleChildScrollView( 
            child: Column( 
              children: [ 
                Container( 
                  padding: const EdgeInsets.symmetric(vertical: 16.0), 
                  decoration: const BoxDecoration( color: Colors.blue, ), 
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [ // header and tags
                      const SizedBox(width: 16.0),
                      WorkoutHeader(workout: widget.currentWorkout), 
                      const SizedBox(height: 16.0), 
                    ], 
                  ), 
                ), 
                const SizedBox(height: 16.0), 
                for (int i = 0; i < exercises.length; i++) 
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ExerciseTile ( // adds the different sets 
                  exercise: exercises[i],
                  onDeleteExercise: () => {},
                  onSetDetailsChanged: (setIndex, reps, weight, distance, time, timeUnit, weightUnit, distanceUnit) {},
                  isEditable: false,
                  updateNotes: (updatedNotes) {
                    workoutViewModel.updateNotes(
                      exercises[i].id as String?,
                      exercises[i].name,
                      updatedNotes,
                    );
                  },
                ),
                ), 
                const SizedBox(height: 15), 
                Intensity(onIntensityChanged: (int intensity){ // intensity can only be edited here, so we have an update intensity function to update the workout list
                  setState(() {
                    selectedIntensity = intensity;
                  });
                }), 
                const SizedBox(height: 16.0), 
                CloseDisplay(selectedIntensity: selectedIntensity, workoutViewModel: workoutViewModel, currentWorkout: widget.currentWorkout), // close display, everything is saved
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
  int selectedIntensity = 1;


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
          const Text(
            'Intensity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Slider(
              value: selectedIntensity.toDouble(),
              min: 1.0,
              max: 10.0,
              divisions: 9, // Number of divisions between min and max
              label: selectedIntensity.toString(), // Display current value
              onChanged: (double newValue) {
                setState(() {
                  selectedIntensity = newValue.round(); // Convert to int
                  widget.onIntensityChanged(selectedIntensity);
                });
              },
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

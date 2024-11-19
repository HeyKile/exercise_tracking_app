import 'package:exercise_tracking_app/models/TemplateModel.dart';
import 'package:exercise_tracking_app/views/widgets/WorkoutSummary.dart';
import 'package:flutter/material.dart';
import 'ExerciseTile.dart';
import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:exercise_tracking_app/viewmodels/WorkoutViewModel.dart';

class LiveWorkout extends StatefulWidget {
  final Template? template;
  const LiveWorkout({super.key, this.template});

  @override
  _LiveWorkoutState createState() => _LiveWorkoutState();
}

class _LiveWorkoutState extends State<LiveWorkout> {
  Workout? currentWorkout;
  List<Exercise> exercises = [];
  WorkoutViewModel workoutViewModel = WorkoutViewModel();

  // extract from selected template
  @override
  void initState() {
    super.initState();
    if (widget.template != null) {
      exercises = widget.template!.exercises.map((templateExercise) => _convertTemplateExercise(templateExercise)).toList();
    }
  }

  Exercise _convertTemplateExercise(TemplateExercise templateExercise) {
    final List<Set> convertedSets = templateExercise.sets.map((templateSet) {
      final map = templateSet as Map<String, dynamic>; 
      return Set(
        reps: map['reps'] != null ? map['reps'] as int : 0,
        weight: map['weight'] != null ? map['weight'] as int : 0,
      );
    }).toList();

    return Exercise(
      name: templateExercise.name,
      sets: convertedSets,
      time: 0, // Set default time (you can adjust based on template data)
    );
  }

  void _addExercise(){
    setState(() {
      exercises.add(Exercise(name: 'New Exercise', sets: [], time: 0));
    });
  }

  void _deleteExercise(int index){
    setState(() {
      if (index >= 0 && index < exercises.length) {
        exercises.removeAt(index);
      }
    });
  }

  void _updateSetDetails(int exerciseIndex, int setIndex, int reps, int weight) {
    setState(() { 
      final updatedSet = Set(reps: reps, weight: weight);
      exercises[exerciseIndex].sets[setIndex] = updatedSet;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WorkoutHeader(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StartStop(
                  icon: Icons.pause,
                  label: 'Pause',
                  onPressed: () {

                  },
                ),
                const Text("20:32"),
                StartStop(
                  icon: Icons.stop,
                  label: 'Finish',
                  onPressed: () {
                  },
                ),
              ],
            ),
            const SizedBox(height:15), // gap
            SetAdd(onAddSet: _addExercise),
            const SizedBox(height:15),
            Column(
              children: [
                for(int i = 0; i < exercises.length; i++) // have to incorporate as custom based on templates
                ExerciseTile(
                  exercise: exercises[i],
                  onDeleteExercise: () => _deleteExercise(i),
                  onSetDetailsChanged: (setIndex, reps, weight) { 
                    _updateSetDetails(i, setIndex, reps, weight);
                  },
                  isEditable: true,
                ),
              ],
            ),
            const SizedBox(height:15),
            SaveWorkout(workoutViewModel: workoutViewModel, exercises: exercises),
            const SizedBox(height:15),
          ],
        )
      )
    );
  }

}

class SetAdd extends StatelessWidget{
  final VoidCallback onAddSet;
  const SetAdd({super.key, required this.onAddSet});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.9, 
      height: 30, 
      child: ElevatedButton(
        onPressed: onAddSet,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          backgroundColor: const Color.fromRGBO(144, 238, 144, 1),
          padding: const EdgeInsets.all(16),
        ),
        child:  const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 10, 
              color: Colors.black, 
            ),
          ],
        ),
      ),
    );
  }
}

class SaveWorkout extends StatelessWidget{
  final WorkoutViewModel workoutViewModel;
  final List<Exercise> exercises;

  const SaveWorkout({super.key, required this.workoutViewModel, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {
          // send info to workout view model to save workout in model
          final currentWorkout = Workout(completed: exercises, tags: [], workoutName: 'hi', intensity: 0, time: 0, date: DateTime.now());
          workoutViewModel.saveWorkout(currentWorkout);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutSummary(workoutViewModel: workoutViewModel, currentWorkout: currentWorkout),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Save Workout',
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

class WorkoutHeader extends StatelessWidget{
  const WorkoutHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: const BoxDecoration(
        color: Colors.blue, 
      ),
      child: const Align(
        alignment: Alignment.center, 
        child: Text(
          'CURRENT WORKOUT',
          style: TextStyle(
            color: Colors.white, 
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class StartStop extends StatelessWidget{
  const StartStop({super.key, required this.icon, required this.label, required this.onPressed});
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(), 
        backgroundColor: Colors.grey,
        padding: const EdgeInsets.all(25), 
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32, // Adjust icon size as needed
            color: Colors.black, // Customize icon color
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
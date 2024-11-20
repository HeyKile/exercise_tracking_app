import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:exercise_tracking_app/models/TemplateModel.dart';
import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:exercise_tracking_app/viewmodels/WorkoutViewModel.dart';
import 'package:exercise_tracking_app/views/widgets/AddExerciseModal.dart';
import 'package:exercise_tracking_app/views/widgets/WorkoutSummary.dart';
import 'package:flutter/material.dart';
import 'ExerciseTile.dart';

class PastWorkout extends StatefulWidget {
  final Template? template;
  const PastWorkout({super.key, required this.template});

  @override
  _PastWorkoutState createState() => _PastWorkoutState();
}

class _PastWorkoutState extends State<PastWorkout>{
  Workout? currentWorkout;
  List<WorkoutExercise> exercises = [];
  WorkoutViewModel workoutViewModel = WorkoutViewModel();
  String _inputTime = '00:00:00';
  //Duration workoutDuration = Duration.zero;

  //extract from template
  @override
  void initState() {
    super.initState();
    if (widget.template != null) {
      exercises = widget.template!.exercises.map((templateExercise) => _convertTemplateExercise(templateExercise)).toList();
    }
  }

  WorkoutExercise _convertTemplateExercise(TemplateExercise templateExercise) {
    final List<Set> convertedSets = templateExercise.sets.map((templateSet) {
      final map = templateSet as Map<String, dynamic>; // Cast to Map
      return Set(
        reps: map['reps'] != null ? map['reps'] as int : 0,
        weight: map['weight'] != null ? map['weight'] as int : 0,
      );
    }).toList();

    return WorkoutExercise(
      name: templateExercise.name,
      sets: convertedSets,
    );
  }

  List<WorkoutExercise> convertExerciseToWorkoutExercise(List<Exercise> exercises) {
    return exercises.map((exercise) => WorkoutExercise(
      name: exercise.name,
      sets: [Set(reps: 0, weight: 0)], 
    )).toList();
  }

  void _addExercise() async {
    final selectedExercises = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExerciseModal()),
    );
    if (selectedExercises != null) {
      setState(() {
        exercises.addAll(convertExerciseToWorkoutExercise(selectedExercises));
      });
    }
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
            const SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 10),
                const Text("Time:"),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      _inputTime = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'HH:MM:SS',
                    ),
                    keyboardType: TextInputType.text, // here is where i want them to input
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.6),
                SetAdd(onAddSet: _addExercise),
                const SizedBox(width: 10)
              ],
            ),
            const SizedBox(height:15),
            Column(
              children: [
                for(int i = 0; i < exercises.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ExerciseTile(
                  exercise: exercises[i],
                  onDeleteExercise: () => _deleteExercise(i),
                  onSetDetailsChanged: (setIndex, reps, weight) { 
                    _updateSetDetails(i, setIndex, reps, weight);
                  },
                  isEditable: true,
                ),
                ),
              ], 
            ),
            const SizedBox(height:15),
            SaveWorkout(workoutViewModel: workoutViewModel, exercises: exercises, workoutDuration: _inputTime),
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
      width: MediaQuery.of(context).size.width * 0.2, 
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
  final List<WorkoutExercise> exercises;
  final String workoutDuration;

  const SaveWorkout({super.key, required this.workoutViewModel, required this.exercises, required this.workoutDuration});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {
          final currentWorkout = Workout(completed: exercises, tags: [], workoutName: 'hi', intensity: 0, time: workoutDuration, date: DateTime.now());
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
        child:  const Column(
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
        color: Colors.blue, // Customize the background color
      ),
      child: const Align(
        alignment: Alignment.center, // Center the text horizontally
        child: Text(
          'CURRENT WORKOUT',
          style: TextStyle(
            color: Colors.white, // Customize the text color
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

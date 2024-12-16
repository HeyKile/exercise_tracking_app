import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:exercise_tracking_app/models/TemplateModel.dart';
import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:exercise_tracking_app/viewmodels/WorkoutViewModel.dart';
import 'package:exercise_tracking_app/views/widgets/AddExerciseModal.dart';
import 'package:exercise_tracking_app/views/widgets/WorkoutSummary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ExerciseTile.dart';

class PastWorkout extends StatefulWidget {
  final Template? template;
  const PastWorkout({super.key, required this.template});

  @override
  // ignore: library_private_types_in_public_api
  _PastWorkoutState createState() => _PastWorkoutState();
}

class _PastWorkoutState extends State<PastWorkout>{
  Workout? currentWorkout;
  List<Exercise> exercises = [];
  WorkoutViewModel workoutViewModel = WorkoutViewModel();
  String _inputTime = '00:00:00';
  String workoutName = '';

  @override
  void initState() {
    super.initState();
    if (widget.template != null) {
      exercises = widget.template!.exercises.map((templateExercise) {
      return templateExercise; 
    }).toList();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addExercise() async { // add exercise to exercises list using Kyle's modal
    final selectedExercises = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExerciseModal()),
    );
    if (selectedExercises != null) {
      setState(() {
        exercises.addAll(selectedExercises);
      });
    }
}

  void _deleteExercise(int index){ // remove exercises when they click x icon from the list and reset state
    setState(() {
      if (index >= 0 && index < exercises.length) {
        exercises.removeAt(index);
      }
    });
  }

  void _updateSetDetails(int exerciseIndex, int setIndex, int reps, int weight, int distance, int time, String timeUnit, String weightUnit, String distanceUnit) { // if they change set numbers, this gets called to update that in the list
    setState(() { 
      final exercise = exercises[exerciseIndex]; 
      final currentSet = exercise.sets[setIndex] as Map<String, dynamic>; 
      
      if (exercise.hasReps) { 
        currentSet['reps'] = reps; 
      } 
      
      if (exercise.hasWeight) { 
        currentSet['weight'] = weight; 
      } 
      
      if (exercise.hasDistance) { 
        currentSet['Distance'] = distance; 
      } 
      
      if (exercise.hasTime) { 
        currentSet['time'] = time; 
      } 
      
      exercise.distanceUnit = distanceUnit;
      exercise.weightUnit = weightUnit;
      exercise.timeUnit = timeUnit;

      exercises[exerciseIndex].sets[setIndex] = currentSet;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WorkoutHeader( // header w workout name
              initialWorkoutName: workoutName,
              onNameChanged: (name) {
                setState(() {
                  workoutName = name;
                });
              },
            ),
            const SizedBox(height:15),
            Row( // time they can input, currently has to be in hh:mm:ss format (will fix later)
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
                    keyboardType: TextInputType.text, 
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.6),
                ExerciseAdd(onAddExercise: _addExercise), // this is Add Exercise button, which will add another exercise
                const SizedBox(width: 10)
              ],
            ),
            const SizedBox(height:15),
            Column(
              children: [
                for(int i = 0; i < exercises.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ExerciseTile ( // adds the different sets 
                  exercise: exercises[i],
                  onDeleteExercise: () => _deleteExercise(i),
                  onSetDetailsChanged: (setIndex, reps, weight, distance, time, timeUnit, weightUnit, distanceUnit) { 
                    _updateSetDetails(i, setIndex, reps, weight, distance, time, timeUnit, weightUnit, distanceUnit);
                  },
                  isEditable: true,
                  updateNotes: (updatedNotes) {
                    workoutViewModel.updateNotes(
                      exercises[i].id as String?,
                      exercises[i].name,
                      updatedNotes,
                    );
                  },
                ),
                )
              ], 
            ),
            const SizedBox(height:15),
            SaveWorkout(workoutViewModel: workoutViewModel, exercises: exercises, workoutDuration: _inputTime, workoutName: workoutName), // save workout button here
            const SizedBox(height:15),
          ],
        )
      )
    );
  }
}

class ExerciseAdd extends StatelessWidget{
  final VoidCallback onAddExercise;
  const ExerciseAdd({super.key, required this.onAddExercise});

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: MediaQuery.of(context).size.width * 0.2, 
      height: 30, 
      child: ElevatedButton(
        onPressed: onAddExercise,
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
  final String workoutDuration;
  final String workoutName;

  const SaveWorkout({super.key, required this.workoutViewModel, required this.exercises, required this.workoutDuration, required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {
          final currentWorkout = Workout(completed: exercises, tags: [], workoutName: workoutName, intensity: 0, time: workoutDuration, date: DateTime.now());
          workoutViewModel.saveWorkout(currentWorkout);
          Navigator.popUntil(
                      context,
                      (route) => route.isFirst,);
          Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => WorkoutSummary(workoutViewModel: workoutViewModel, currentWorkout: currentWorkout)
        ));
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

class WorkoutHeader extends StatefulWidget {
  final String initialWorkoutName;
  final ValueChanged<String> onNameChanged;

  const WorkoutHeader({super.key, required this.initialWorkoutName, required this.onNameChanged});

  @override
  State<WorkoutHeader> createState() => _WorkoutHeaderState();
}

class _WorkoutHeaderState extends State<WorkoutHeader> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialWorkoutName);

    _textController.addListener(() {
      widget.onNameChanged(_textController.text);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, // Limit width
          child: TextField(
            controller: _textController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none, // Remove default border
              hintText: 'Enter workout name...',
              hintStyle: TextStyle(color: Colors.white70),
            ),
            textAlign: TextAlign.center, // Center the text
          ),
        ),
      ),
    );
  }
}

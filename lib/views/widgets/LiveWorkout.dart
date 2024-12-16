import 'dart:async';
import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:exercise_tracking_app/models/TemplateModel.dart';
import 'package:exercise_tracking_app/views/widgets/AddExerciseModal.dart';
import 'package:exercise_tracking_app/views/widgets/WorkoutSummary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
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
  final Stopwatch _stopwatch = Stopwatch();
  Duration _elapsedTime = const Duration();
  late Timer timer;
  bool _isTimerRunning = false;
  String workoutName = '';

  @override
  void initState() {
    super.initState();
    
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.template != null) {
        setState(() {
          exercises = widget.template!.exercises.map((templateExercise) {
            return templateExercise;
          }).toList();
        });
      }
      
      _stopwatch.start();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime = _stopwatch.elapsed;
        });
      });
    });
  }

   @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  void _addExercise() async {
    final selectedExercises = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExerciseModal()),
    );
    if (selectedExercises != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          exercises.addAll(selectedExercises);
        });
      });
    }
  }


  void _deleteExercise(int index){
    setState(() {
      if (index >= 0 && index < exercises.length) {
        exercises.removeAt(index);
      } else {
        print("Index out of range: $index");
      }
    });
  }

  void _updateSetDetails(int exerciseIndex, int setIndex, int reps, int weight, int distance, int time, String timeUnit, String weightUnit, String distanceUnit) {
    setState(() { 
      if (exerciseIndex < 0 || exerciseIndex >= exercises.length) { 
        print("Exercise index out of range: $exerciseIndex"); 
        return; 
      }

      final exercise = exercises[exerciseIndex]; 

      if (setIndex < 0 || setIndex >= exercise.sets.length) { 
        print("Set index out of range: $setIndex"); 
        return; 
      }

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

  void _toggleTimer() { // starts / stops based on pause / start
    setState(() {
      _isTimerRunning = !_isTimerRunning;
      if (_isTimerRunning) {
        _stopwatch.start();
      } else {
        _stopwatch.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _elapsedTime = _stopwatch.elapsed;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WorkoutHeader(
              initialWorkoutName: workoutName,
              onNameChanged: (name) {
                setState(() {
                  workoutName = name;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StartStop( // timing, pause and start
                  icon: _isTimerRunning ? Icons.play_arrow : Icons.pause,
                  label: _isTimerRunning ? 'Start' :'Pause',
                  onPressed: _toggleTimer,
                ),
                Text(_elapsedTime.toString().substring(0,7)), // time that's passed
                StartStop( 
                  icon: Icons.stop,
                  label: 'Finish',
                  onPressed: () {
                    final currentWorkout = Workout(completed: exercises, tags: [], workoutName: workoutName, intensity: 0, time: _elapsedTime.toString().substring(0,7), date: DateTime.now());
                    debugPrint('current workout: $currentWorkout');
                    workoutViewModel.saveWorkout(currentWorkout);
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,);
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutSummary(workoutViewModel: workoutViewModel, currentWorkout: currentWorkout)
                      ));
                  },
                ),
              ],
            ),
            const SizedBox(height:15), // gap
            ExerciseAdd(onAddExercise: _addExercise),
            const SizedBox(height:15),
            Column(
              children: [
                for(int i = 0; i < exercises.length; i++) // have to incorporate as custom based on templates
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ExerciseTile( // different sets, populates from template
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
          ],
        )
      )
    );
  }

}

class ExerciseAdd extends StatelessWidget{ // add exercise here
  final VoidCallback onAddExercise;
  const ExerciseAdd({super.key, required this.onAddExercise});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.9, 
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
          width: MediaQuery.of(context).size.width * 0.9, 
          child: TextField(
            controller: _textController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter workout name...',
              hintStyle: TextStyle(color: Colors.white70),
            ),
            textAlign: TextAlign.center, 
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
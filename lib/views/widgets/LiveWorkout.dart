import 'dart:async';
import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:exercise_tracking_app/models/TemplateModel.dart';
import 'package:exercise_tracking_app/views/widgets/AddExerciseModal.dart';
import 'package:exercise_tracking_app/views/widgets/WorkoutSummary.dart';
import 'package:flutter/material.dart';
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
  List<WorkoutExercise> exercises = [];
  WorkoutViewModel workoutViewModel = WorkoutViewModel();
  final Stopwatch _stopwatch = Stopwatch();
  Duration _elapsedTime = const Duration();
  late Timer timer;
  bool _isTimerRunning = true;
  String workoutName = '';

  @override
  void initState() {
    super.initState();
    print(widget.template != null);
    print(widget.template?.name);
    if (widget.template != null) {
      exercises = widget.template!.exercises.map((templateExercise) {
      print("Processing TemplateExercise: ${templateExercise.name}"); 
      return _convertTemplateExercise(templateExercise); 
    }).toList();

    print("Exercises after conversion: $exercises"); 
    }
    _stopwatch.start(); // set up stopwatch to start time
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState((){
        _elapsedTime = _stopwatch.elapsed;
      });
    });
  }

   @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // the next two methods will need to be improved. currently there are 3 exercise classes so have to convert between them
  // which is an L. so fixing that soon lol

  WorkoutExercise _convertTemplateExercise(TemplateExercise templateExercise) {
    print(templateExercise.unit);
    print("Processing TemplateExercise: ${templateExercise.name}"); 
    print("TemplateExercise sets: ${templateExercise.sets}"); 
    String units = templateExercise.unit;
    final List<Set> convertedSets = templateExercise.sets.map((templateSet) {
      print(templateSet);
      final map = templateSet as Map<String, dynamic>;
      print("yooo $map");
      print("unit from template $units");
      return Set(
        reps: map['reps'] != null ? map['reps'] as int : 0,
        weight: map['weight'] != null ? map['weight'] as int : 0,
        unit: units,
        time: map['Time'] != null ? map['Time'] as int : 0,
        distance: map['Distance'] != null ? map['Distance'] as int : 0
      );
    }).toList();

    return WorkoutExercise(
      name: templateExercise.name,
      sets: convertedSets,
      notes: "",
    );
  }

  List<WorkoutExercise> convertExerciseToWorkoutExercise(List<Exercise> exercises) {
    String unit = exercises[0].trackedStats[0].unit ?? '';
    print("unit from exercise model $unit");
    return exercises.map((exercise) => WorkoutExercise(
      name: exercise.name,
      sets: [Set(reps: 0, weight: 0, unit: unit, time: 0, distance: 0)], 
      notes: "",
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

  void _updateSetDetails(int exerciseIndex, int setIndex, int reps, int weight, int distance, int time, String unit) {
    setState(() { 
      final updatedSet = Set(reps: reps, weight: weight, unit: unit, distance: distance, time: time);
      exercises[exerciseIndex].sets[setIndex] = updatedSet;
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
                  onPressed: () {
                    _toggleTimer();
                  },
                ),
                Text(_elapsedTime.toString().substring(0,7)), // time that's passed
                StartStop( 
                  icon: Icons.stop,
                  label: 'Finish',
                  onPressed: () {
                    final currentWorkout = Workout(completed: exercises, tags: [], workoutName: workoutName, intensity: 0, time: _elapsedTime.toString().substring(0,7), date: DateTime.now());
                    debugPrint('current workout: $currentWorkout');
                    workoutViewModel.saveWorkout(currentWorkout);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutSummary(workoutViewModel: workoutViewModel, currentWorkout: currentWorkout),
                      ), (Route<dynamic> route) => false
                    );
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
                  child: ChangeNotifierProvider(
                  create: (context) => ExerciseTileStateNotifier(),
                  child: ExerciseTile( // different sets, populates from template
                  exercise: exercises[i],
                  onDeleteExercise: () => _deleteExercise(i),
                  onSetDetailsChanged: (setIndex, reps, weight, distance, time, unit) { 
                    _updateSetDetails(i, setIndex, reps, weight, distance, time, unit);
                  },
                  isEditable: true,
                  updateNotes: (updatedNotes) {
                    workoutViewModel.updateNotes(
                      exercises[i].id,
                      exercises[i].name,
                      updatedNotes,
                    );
                  },
                ),
                )
                ),
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
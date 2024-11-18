import 'package:exercise_tracking_app/viewmodels/ExerciseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/ExerciseModel.dart';

class AddExerciseModal extends StatefulWidget {
  const AddExerciseModal({super.key,});

  @override
  State<AddExerciseModal> createState() => _AddExerciseModalState();
}

class _AddExerciseModalState extends State<AddExerciseModal> {
  List<Exercise> selectedExercises = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise')
      ),
      body: Consumer<ExerciseViewModel>(
        builder: (context, exerciseViewModel, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: exerciseViewModel.exercises.length,
            itemBuilder: (context, index) {
              final exercise = exerciseViewModel.exercises[index];
              final isSelected = selectedExercises.contains(exercise);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedExercises.remove(exercise);
                    }
                    else {
                      selectedExercises.add(exercise);
                    }
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 3.0,
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(exercise.name),
                      Text('ID: ${exercise.id}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, selectedExercises);
        },
        child: const Icon(Icons.check),
      ),
    );
  }

}
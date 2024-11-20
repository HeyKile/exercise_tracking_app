import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:flutter/material.dart';
import 'ExerciseTileListItem.dart';

class ExerciseTile extends StatefulWidget{
  final WorkoutExercise exercise;
  final bool isEditable;
  final VoidCallback onDeleteExercise;
  final Function(int setIndex, int reps, int weight) onSetDetailsChanged;
  
  const ExerciseTile({super.key, required this.exercise, required this.onDeleteExercise, required this.isEditable, required this.onSetDetailsChanged});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  String _selectedUnit = 'Unit';

  late List<TextEditingController> _repsControllers; 
  late List<TextEditingController> _weightControllers;

  @override void initState() { 
    super.initState(); _repsControllers = List.generate( widget.exercise.sets.length, (index) => TextEditingController(text: widget.exercise.sets[index].reps.toString()), 
    ); 
    _weightControllers = List.generate( widget.exercise.sets.length, (index) => TextEditingController(text: widget.exercise.sets[index].weight.toString()), 
    ); 
  } 
  
  @override void dispose() { 
    for (var controller in _repsControllers) { 
      controller.dispose(); } 
    for (var controller in _weightControllers) { 
      controller.dispose(); } 
    super.dispose(); 
  }

  void _addSet() {
    setState(() {
      widget.exercise.sets.add(Set(reps: 0, weight: 0)); 
      _repsControllers.add(TextEditingController(text: '0')); 
      _weightControllers.add(TextEditingController(text: '0'));
    });
  }

  void _changeUnit(String? newUnit) {
    if(newUnit != null) {
      setState(() {
        _selectedUnit = newUnit;
      });
    }
  }
  
  void _deleteExercise() {
    widget.onDeleteExercise(); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      width: MediaQuery.of(context).size.width * 0.97,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.exercise.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text('Add Notes'),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                      },
                    ),
                    widget.isEditable ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _deleteExercise,
                    ) : 
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: (){},
                    ),
                  ],
                ),
              ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < widget.exercise.sets.length; i++)
          ExerciseTileListItem(
              setNumber: i + 1,
              repsController: TextEditingController(text: widget.exercise.sets[i].reps.toString()),
              weightController: TextEditingController(text: widget.exercise.sets[i].weight.toString()),
              onUnitChanged: _changeUnit,
              isEditable: widget.isEditable,
              unit: _selectedUnit,
              onRepsChanged: (reps) { 
                setState(() { 
                  widget.exercise.sets[i].reps = int.parse(reps); 
                  widget.onSetDetailsChanged(i, widget.exercise.sets[i].reps, widget.exercise.sets[i].weight); 
                }); 
              }, 
              onWeightChanged: (weight) { 
                setState(() { 
                  widget.exercise.sets[i].weight = int.parse(weight); 
                  widget.onSetDetailsChanged(i, widget.exercise.sets[i].reps, widget.exercise.sets[i].weight); 
                });
              }
          ),
          widget.isEditable
          ? ElevatedButton(
            onPressed: _addSet,
            child: const Align(
              alignment: Alignment.center,
              child: Text('Add Set')
            ),
          )
          : const SizedBox(),
        ],
      ),
    );
  }
}
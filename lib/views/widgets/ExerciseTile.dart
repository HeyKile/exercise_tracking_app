import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:exercise_tracking_app/views/widgets/AddNotesPopUp.dart';
import 'package:flutter/material.dart';
import 'ExerciseTileListItem.dart';

class ExerciseTile extends StatefulWidget{
  final WorkoutExercise exercise;
  final bool isEditable;
  final VoidCallback onDeleteExercise;
  final Function(int setIndex, int reps, int weight) onSetDetailsChanged;
  final Function(String notes) updateNotes;

  const ExerciseTile({super.key, required this.exercise, required this.onDeleteExercise, required this.isEditable, required this.onSetDetailsChanged, required this.updateNotes});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  String _selectedUnit = 'lbs'; // still have yet to implement units! and other exercises besides lifting

  late List<TextEditingController> _repsControllers; 
  late List<TextEditingController> _weightControllers;
  late TextEditingController _notesController;

  @override void initState() { // initialize controllers for the text fields
    super.initState(); 
    _repsControllers = List.generate( widget.exercise.sets.length, (index) => TextEditingController(text: widget.exercise.sets[index].reps.toString())); 
    _weightControllers = List.generate( widget.exercise.sets.length, (index) => TextEditingController(text: widget.exercise.sets[index].weight.toString())); 
    _notesController = TextEditingController(text: widget.exercise.notes);
  } 
  
  @override void dispose() { 
    _notesController.dispose();
    for (var controller in _repsControllers) { 
      controller.dispose(); 
    } 
    for (var controller in _weightControllers) { 
      controller.dispose(); 
    } 
    super.dispose(); 
  }

  void addSet() {
    setState(() { // adding sets to the list and to the controller list
      widget.exercise.sets.add(Set(reps: 0, weight: 0)); 
      _repsControllers.add(TextEditingController(text: '0')); 
      _weightControllers.add(TextEditingController(text: '0'));
    });
  }

  void changeUnit(String? newUnit) { // changes the units through the drop down
    if(newUnit != null) {
      setState(() {
        _selectedUnit = newUnit;
      });
    }
  }
  
  void deleteExercise() {
    widget.onDeleteExercise(); 
  }

  void saveNotes(String updatedNotes) {
    setState(() {
      widget.exercise.notes = updatedNotes;
    });
    widget.updateNotes(updatedNotes);
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
                  children: [ // add notes, depending on if the screen is editable or not
                    widget.isEditable ? const Text('Add Notes') : const Text(''),
                    widget.isEditable ? IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) => AddNotesPopup(
                            existingNote: widget.exercise.notes,
                            onSave: saveNotes
                          )
                        );
                      },
                    ) : const SizedBox(),
                    widget.isEditable ? IconButton( // same with deleting exercises
                      icon: const Icon(Icons.close),
                      onPressed: deleteExercise,
                    ) : const SizedBox(),
                  ],
                ),
              ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < widget.exercise.sets.length; i++)
          ExerciseTileListItem( // printing the list of the sets
              setNumber: i + 1,
              repsController: TextEditingController(text: widget.exercise.sets[i].reps.toString()),
              weightController: TextEditingController(text: widget.exercise.sets[i].weight.toString()),
              onUnitChanged: changeUnit,
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
          ? ElevatedButton( // adding sets to the exercise
            onPressed: addSet,
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
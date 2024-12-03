import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:exercise_tracking_app/views/widgets/AddNotesPopUp.dart';
import 'package:exercise_tracking_app/views/widgets/CustomRoundedExpansionTile.dart';
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
    return Padding( 
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), 
      child: CustomRoundedExpansionTile( 
        tileColor: Colors.blue, 
        shape: RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(8.0), 
        ), 
        boxDecoration: BoxDecoration( 
          border: Border( 
            bottom: BorderSide(width: 2.0, color: Colors.blue[800]!.withOpacity(0.4)), 
            right: BorderSide(width: 2.0, color: Colors.blue[800]!.withOpacity(0.4)), 
          ), 
          borderRadius: const BorderRadius.only( 
            bottomLeft: Radius.circular(10.0), 
            bottomRight: Radius.circular(10.0), 
            topLeft: Radius.zero, 
            topRight: Radius.circular(10.0), 
          ), 
        ), 
        duration: const Duration(milliseconds: 50), 
        leading: const Icon(Icons.chevron_left_rounded), 
        trailing: widget.isEditable ? IconButton( 
          icon: const Icon(Icons.highlight_remove_rounded), 
          onPressed: deleteExercise, 
        ) : const SizedBox.shrink(),  
        title: Text( 
          widget.exercise.name, 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20), 
        ), 
        children: [ 
          Container( 
            margin: const EdgeInsets.only(left: 6.0, right: 6.0), 
            decoration: BoxDecoration( 
              color: Colors.grey[200], 
              border: Border( 
                right: BorderSide(
                  color: Colors.grey[700]!.withOpacity(0.35)), 
                  bottom: BorderSide(color: Colors.grey[700]!.withOpacity(0.35)), 
              ), 
              borderRadius: const BorderRadius.only( 
                bottomLeft: Radius.circular(10.0), 
                bottomRight: Radius.circular(10.0), 
                topLeft: Radius.zero, 
                topRight: Radius.zero, 
              ), 
            ), 
            child: Padding( 
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0), 
              child: Column( 
                children: [ 
                  ...widget.exercise.sets.map((set) { 
                    int index = widget.exercise.sets.indexOf(set);
                    return Container( 
                      decoration: BoxDecoration( 
                        color: Colors.white, 
                        border: Border( 
                          right: BorderSide(color: Colors.grey[700]!.withOpacity(0.4)), 
                          bottom: BorderSide(color: Colors.grey[700]!.withOpacity(0.4)), 
                        ), 
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)), 
                      ), 
                      margin: const EdgeInsets.symmetric(vertical: 3.0), 
                      child: Row( 
                        children: [ 
                          Expanded(
                            child: ExerciseTileListItem(
                              setNumber: index + 1, 
                              repsController: _repsControllers[index], 
                              weightController: _weightControllers[index], 
                              onUnitChanged: changeUnit, 
                              isEditable: widget.isEditable, 
                              unit: _selectedUnit, 
                              onRepsChanged: (reps) { 
                                setState(() { 
                                  widget.exercise.sets[index].reps = int.parse(reps); 
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index].reps, widget.exercise.sets[index].weight); 
                                }); 
                              }, 
                              onWeightChanged: (weight) { 
                                setState(() { 
                                  widget.exercise.sets[index].weight = int.parse(weight); 
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index].reps, widget.exercise.sets[index].weight); 
                                }); 
                              },
                            )), 
                            widget.isEditable ? IconButton( 
                              icon: const Icon(Icons.delete), 
                              onPressed: () { 
                                setState(() { 
                                  widget.exercise.sets.removeAt(index); 
                                }); 
                              }, 
                            ) : const SizedBox.shrink(), 
                        ], 
                      ), 
                    ); 
                  }), 
                  widget.isEditable ? Padding( 
                    padding: const EdgeInsets.symmetric(vertical: 3.0), 
                    child: ElevatedButton( 
                      onPressed: addSet, 
                      style: const ButtonStyle( 
                        foregroundColor: WidgetStatePropertyAll<Color>(Colors.black), 
                        backgroundColor: WidgetStatePropertyAll<Color>(Colors.white), 
                        shadowColor: WidgetStatePropertyAll<Color>(Colors.grey), 
                      ), 
                      child: const Text("Add Set"), 
                    ), 
                  ) : const SizedBox.shrink(), 
                ], 
              ), 
            ), 
          ), 
        ], 
      ),
    );
  }
}
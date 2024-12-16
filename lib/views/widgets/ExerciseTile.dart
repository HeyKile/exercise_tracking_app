import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:exercise_tracking_app/views/widgets/AddNotesPopUp.dart';
import 'package:exercise_tracking_app/views/widgets/CustomRoundedExpansionTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'ExerciseTileListItem.dart';

class ExerciseTile extends StatefulWidget{
  final Exercise exercise;
  final bool isEditable;
  final VoidCallback onDeleteExercise;
  final Function(int setIndex, int reps, int weight, int distance, int time, String timeUnit, String weightUnit, String distanceUnit) onSetDetailsChanged;
  final Function(String notes) updateNotes;

  const ExerciseTile({super.key, required this.exercise, required this.onDeleteExercise, required this.isEditable, required this.onSetDetailsChanged, required this.updateNotes});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  late String _timeUnit; // still have yet to implement units! and other exercises besides lifting
  late String _weightUnit;
  late String _distanceUnit;
  late TextEditingController _notesController;

  @override void initState() { // initialize controllers for the text fields
    super.initState(); 
    _timeUnit = widget.exercise.timeUnit;
    _distanceUnit = widget.exercise.distanceUnit;
    _weightUnit = widget.exercise.weightUnit;
    _notesController = TextEditingController(text: widget.exercise.notes);
  } 
  
  @override void dispose() { 
    _notesController.dispose();
    super.dispose(); 
  }

  void addSet() {
    setState(() { // adding sets to the list and to the controller list
      Map<String, dynamic> newSet = {};

      if(widget.exercise.hasReps){
        newSet['reps'] = 0;
      }

      if(widget.exercise.hasWeight){
        newSet['weight'] = 0;
      }

      if(widget.exercise.hasDistance){
        newSet['Distance'] = 0;
      }

      if(widget.exercise.hasTime){
        newSet['Time'] = 0;
      }

      widget.exercise.sets.add(newSet);
    });
  }

  void changeWeightUnit(String? newUnit) { // changes the units through the drop down
    if(newUnit != null) {
      setState(() {
        _weightUnit = newUnit;
        widget.exercise.weightUnit = newUnit;
      });
    }
  }
  
    void changeTimeUnit(String? newUnit) { // changes the units through the drop down
    if(newUnit != null) {
      setState(() {
        _timeUnit = newUnit;
        widget.exercise.timeUnit = newUnit;
      });
    }
  }

    void changeDistanceUnit(String? newUnit) { // changes the units through the drop down
    if(newUnit != null) {
      setState(() {
        _distanceUnit = newUnit;
        widget.exercise.distanceUnit = newUnit;
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
        trailing: Row( 
          mainAxisSize: MainAxisSize.min, 
          children: [ 
            widget.isEditable ? IconButton( 
              icon: const Icon(Icons.edit), 
              onPressed: () { 
                showDialog( 
                  context: context, 
                  builder: (context) => AddNotesPopup( existingNote: widget.exercise.notes, onSave: saveNotes, ), 
                ); 
              }, 
            ) : const SizedBox.shrink(), 
            widget.isEditable ? IconButton( 
              icon: const Icon(Icons.highlight_remove_rounded), 
              onPressed: deleteExercise, 
            ) : const SizedBox.shrink(), 
          ], 
        ),
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
                              repsController: TextEditingController(text: set['reps'].toString()), 
                              weightController: TextEditingController(text: set['weight'].toString()), 
                              onWeightUnitChanged: changeWeightUnit, 
                              onDistanceUnitChanged: changeDistanceUnit,
                              onTimeUnitChanged: changeTimeUnit,
                              hasDistance: widget.exercise.hasDistance,
                              hasReps: widget.exercise.hasReps,
                              hasTime: widget.exercise.hasTime,
                              hasWeight: widget.exercise.hasWeight,
                              isEditable: widget.isEditable, 
                              distanceController: TextEditingController(text: set['Distance'].toString()),
                              timeController: TextEditingController(text: set['Time'].toString()),
                              weightUnit: _weightUnit,
                              timeUnit: _timeUnit,
                              distanceUnit: _distanceUnit, 
                              onRepsChanged: (reps) { 
                                setState(() { 
                                  widget.exercise.sets[index]['reps'] = int.parse(reps); 
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index]['reps'] ?? -1, widget.exercise.sets[index]['weight'] ?? -1, widget.exercise.sets[index]['Distance'] ?? -1, widget.exercise.sets[index]['Time'] ?? -1, widget.exercise.timeUnit, widget.exercise.weightUnit, widget.exercise.distanceUnit); 
                                }); 
                              }, 
                              onDistanceChanged: (distance){
                                setState(() {
                                  widget.exercise.sets[index]['Distance'] = int.parse(distance);
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index]['reps'] ?? -1, widget.exercise.sets[index]['weight'] ?? -1, widget.exercise.sets[index]['Distance'] ?? -1, widget.exercise.sets[index]['Time'] ?? -1, widget.exercise.timeUnit, widget.exercise.weightUnit, widget.exercise.distanceUnit);                                   
                                });
                              },
                              onTimeChanged: (time){
                                setState(() {
                                  widget.exercise.sets[index]['Time'] = int.parse(time);
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index]['reps'] ?? -1, widget.exercise.sets[index]['weight'] ?? -1, widget.exercise.sets[index]['Distance'] ?? -1, widget.exercise.sets[index]['Time'] ?? -1, widget.exercise.timeUnit, widget.exercise.weightUnit, widget.exercise.distanceUnit);   
                                });
                              },
                              onWeightChanged: (weight) { 
                                setState(() { 
                                  widget.exercise.sets[index]['weight'] = int.parse(weight); 
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index]['reps'] ?? -1, widget.exercise.sets[index]['weight'] ?? -1, widget.exercise.sets[index]['Distance'] ?? -1, widget.exercise.sets[index]['Time'] ?? -1, widget.exercise.timeUnit, widget.exercise.weightUnit, widget.exercise.distanceUnit); 
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
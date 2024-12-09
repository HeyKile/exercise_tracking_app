import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:exercise_tracking_app/models/WorkoutModel.dart';
import 'package:exercise_tracking_app/viewmodels/ExerciseViewModel.dart';
import 'package:exercise_tracking_app/views/widgets/AddNotesPopUp.dart';
import 'package:exercise_tracking_app/views/widgets/CustomRoundedExpansionTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ExerciseTileListItem.dart';

class ExerciseTile extends StatefulWidget{
  final WorkoutExercise exercise;
  final bool isEditable;
  final VoidCallback onDeleteExercise;
  final Function(int setIndex, int reps, int weight, int distance, int time, String unit) onSetDetailsChanged;
  final Function(String notes) updateNotes;

  const ExerciseTile({super.key, required this.exercise, required this.onDeleteExercise, required this.isEditable, required this.onSetDetailsChanged, required this.updateNotes});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  late String _selectedUnit; // still have yet to implement units! and other exercises besides lifting
  late List<TextEditingController> _repsControllers; 
  late List<TextEditingController> _weightControllers;
  late List<TextEditingController> _distanceControllers; 
  late List<TextEditingController> _timeControllers;
  late TextEditingController _notesController;
  bool hasReps = false;
  bool hasDistance = false;
  bool hasTime = false;
  bool hasWeight = false;

  @override void initState() { // initialize controllers for the text fields
    super.initState(); 
    _selectedUnit = widget.exercise.sets.isNotEmpty ? widget.exercise.sets[0].unit : 'lbs';
    widget.exercise.sets.forEach((set) {
    print('Set:');
    print('  Reps: ${set.reps}');
    print('  Weight: ${set.weight}');
    print('  Unit: ${set.unit}');
    print('-------------------'); 
  });
    print('initial selected unit: $_selectedUnit');
    _repsControllers = List.generate( widget.exercise.sets.length, (index) => TextEditingController(text: widget.exercise.sets[index].reps.toString())); 
    _weightControllers = List.generate( widget.exercise.sets.length, (index) => TextEditingController(text: widget.exercise.sets[index].weight.toString())); 
    _distanceControllers = List.generate( widget.exercise.sets.length, (index) => TextEditingController(text: widget.exercise.sets[index].distance.toString())); 
    _timeControllers = List.generate( widget.exercise.sets.length, (index) => TextEditingController(text: widget.exercise.sets[index].time.toString())); 
    _notesController = TextEditingController(text: widget.exercise.notes);

    WidgetsBinding.instance.addPostFrameCallback((_){
        fetchAndSetExerciseBooleans();
    });// have to figure out how to pass in booleans into exercise tile item

  } 

  void fetchAndSetExerciseBooleans() async{
    await Provider.of<ExerciseViewModel>(context, listen: false).fetchExercises();
    Exercise? exercise = getExerciseByName(widget.exercise.name);

    if(exercise != null){
      for(var stat in exercise.trackedStats){
        if(stat.type == TrackableStat.weight){
          hasWeight = true;
        }
        else if(stat.type == TrackableStat.time){
          hasTime = true;
        }
        else if(stat.type == TrackableStat.distance){
          hasDistance = true;
        }
        else if(stat.type == TrackableStat.reps){
          hasReps = true;
        }
      }
    }
  }

  Exercise? getExerciseByName(String name){
    try{
      List<Exercise> allExercises = Provider.of<ExerciseViewModel>(context, listen: false).exercises;
      return allExercises.firstWhere(
        (exercise) => exercise.name == name,
      );
    }
    catch (e){
      print("error");
      return null;
    }
  }
  
  @override void dispose() { 
    _notesController.dispose();
    for (var controller in _repsControllers) { 
      controller.dispose(); 
    } 
    for (var controller in _weightControllers) { 
      controller.dispose(); 
    } 
    for (var controller in _distanceControllers) { 
      controller.dispose(); 
    } 
    for (var controller in _timeControllers) { 
      controller.dispose(); 
    } 
    super.dispose(); 
  }

  void addSet() {
    setState(() { // adding sets to the list and to the controller list
      widget.exercise.sets.add(Set(reps: 0, weight: 0, unit:_selectedUnit, time: 0, distance:0)); 
      _repsControllers.add(TextEditingController(text: '0')); 
      _weightControllers.add(TextEditingController(text: '0'));
      _distanceControllers.add(TextEditingController(text: '0'));
      _timeControllers.add(TextEditingController(text: '0'));
    });
  }

  void changeUnit(String? newUnit) { // changes the units through the drop down
    if(newUnit != null) {
      setState(() {
        _selectedUnit = newUnit;
        for(var set in widget.exercise.sets){
          set.unit = newUnit;
        }
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
    print("reps $hasReps");
    print("weight $hasWeight");
    print("time $hasTime");
    print("distance $hasDistance");
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
                              setNumber: index + 1, 
                              repsController: _repsControllers[index], 
                              weightController: _weightControllers[index], 
                              onUnitChanged: changeUnit, 
                              hasDistance: hasDistance,
                              hasReps: hasReps,
                              hasTime: hasTime,
                              hasWeight: hasWeight,
                              isEditable: widget.isEditable, 
                              distanceController: TextEditingController(text: set.distance.toString()),
                              timeController: TextEditingController(text: set.time.toString()),
                              unit: _selectedUnit, 
                              onRepsChanged: (reps) { 
                                setState(() { 
                                  widget.exercise.sets[index].reps = int.parse(reps); 
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index].reps ?? -1, widget.exercise.sets[index].weight ?? -1, widget.exercise.sets[index].distance ?? -1, widget.exercise.sets[index].time ?? -1, widget.exercise.sets[index].unit); 
                                }); 
                              }, 
                              onDistanceChanged: (distance){
                                setState(() {
                                  widget.exercise.sets[index].distance = int.parse(distance);
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index].reps ?? -1, widget.exercise.sets[index].weight ?? -1, widget.exercise.sets[index].distance ?? -1, widget.exercise.sets[index].time ?? -1, widget.exercise.sets[index].unit);                                   
                                });
                              },
                              onTimeChanged: (time){
                                setState(() {
                                  widget.exercise.sets[index].time = int.parse(time);
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index].reps ?? -1, widget.exercise.sets[index].weight ?? -1, widget.exercise.sets[index].distance ?? -1, widget.exercise.sets[index].time ?? -1, widget.exercise.sets[index].unit);   
                                });
                              },
                              onWeightChanged: (weight) { 
                                setState(() { 
                                  widget.exercise.sets[index].weight = int.parse(weight); 
                                  widget.onSetDetailsChanged(index, widget.exercise.sets[index].reps ?? -1, widget.exercise.sets[index].weight ?? -1, widget.exercise.sets[index].distance ?? -1, widget.exercise.sets[index].time ?? -1, widget.exercise.sets[index].unit); 
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
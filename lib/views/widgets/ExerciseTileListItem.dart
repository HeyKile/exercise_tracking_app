import 'package:flutter/material.dart';

class ExerciseTileListItem extends StatelessWidget { // this is the line of sets, called in ExerciseTile
  final TextEditingController repsController;
  final TextEditingController weightController;
  final TextEditingController distanceController;
  final TextEditingController timeController;
  final ValueChanged<String?>? onWeightUnitChanged;
  final ValueChanged<String?>? onDistanceUnitChanged;
  final ValueChanged<String?>? onTimeUnitChanged;
  final ValueChanged<String> onRepsChanged; 
  final ValueChanged<String> onWeightChanged;
  final ValueChanged<String> onDistanceChanged; 
  final ValueChanged<String> onTimeChanged;
  final bool isEditable;
  final bool hasReps;
  final bool hasDistance;
  final bool hasTime;
  final bool hasWeight;
  final String distanceUnit;
  final String weightUnit;
  final String timeUnit;

  const ExerciseTileListItem({
    super.key,
    required this.repsController,
    required this.weightController,
    required this.distanceController,
    required this.timeController,
    required this.onWeightUnitChanged,
    required this.onTimeUnitChanged,
    required this.onDistanceUnitChanged,
    required this.isEditable,
    required this.onRepsChanged,
    required this.onWeightChanged,
    required this.weightUnit,
    required this.timeUnit,
    required this.distanceUnit, 
    required this.onDistanceChanged, 
    required this.onTimeChanged, 
    required this.hasReps, 
    required this.hasDistance, 
    required this.hasTime, 
    required this.hasWeight, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          if(hasReps) const SizedBox(width: 16),
          if(hasReps) Expanded(
            child: TextField(
              controller: repsController,
              enabled: isEditable,
              decoration: const InputDecoration(
                hintText: 'Reps',
              ),
              keyboardType: const TextInputType.numberWithOptions(signed:false),
              onChanged: (value) { 
                int reps = int.tryParse(value) ?? 0; 
                repsController.text = reps.toString();
                onRepsChanged(reps.toString());
              },
            ),
          ),
          if(hasReps || hasWeight) const SizedBox(width: 16),
          if(hasWeight) Expanded(
            child: TextField(
              controller: weightController,
              enabled: isEditable,
              decoration: const InputDecoration(
                hintText: 'Weight',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) { 
                int weight = int.tryParse(value) ?? 0; 
                weightController.text = weight.toString();
                onWeightChanged(weight.toString());
              },
            ),
          ),
          if(hasWeight || hasDistance) const SizedBox(width: 16),
          if(hasDistance) Expanded(
            child: TextField(
              controller: distanceController,
              enabled: isEditable,
              decoration: const InputDecoration(
                hintText: 'Distance',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) { 
                int distance = int.tryParse(value) ?? 0; 
                distanceController.text = distance.toString();
                onDistanceChanged(distance.toString());
              },
            ),
          ),
          if(hasDistance) const SizedBox(width: 16),
          if(hasDistance) Expanded(
            child: isEditable ? DropdownButtonFormField<String>(
              value: distanceUnit, // Default value
              items: const [
                DropdownMenuItem(value: '', child: Text('')),
                DropdownMenuItem(value: 'mi', child: Text('mi')),
                DropdownMenuItem(value: 'km', child: Text('km')),
                DropdownMenuItem(value: 'yds', child: Text('yds')),
                DropdownMenuItem(value: 'meters', child: Text('m')),
              ],
              onChanged: (value) { 
                if (onDistanceUnitChanged != null) { 
                  onDistanceUnitChanged!(value); 
                } 
              }
            ) : Text(
                    distanceUnit, 
                    style: const TextStyle(fontSize: 16),
            ),
          ),
          if(hasTime) Expanded(
            child: TextField(
              controller: timeController,
              enabled: isEditable,
              decoration: const InputDecoration(
                hintText: 'Time',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) { 
                int time = int.tryParse(value) ?? 0; 
                timeController.text = time.toString();
                onTimeChanged(time.toString());
              },
            ),
          ),
          if(hasTime) Expanded(
            child: isEditable ? DropdownButtonFormField<String>(
              value: timeUnit, // Default value
              items: const [
                DropdownMenuItem(value: '', child: Text('')),
                DropdownMenuItem(value: 'mins', child: Text('mins')),
                DropdownMenuItem(value: 'secs', child: Text('secs')),
              ],
              onChanged: (value) { 
                if (onTimeUnitChanged != null) { 
                  onTimeUnitChanged!(value); 
                } 
              }
            ) : Text(
                    timeUnit, 
                    style: const TextStyle(fontSize: 16),
            ),
          ),
          if(hasWeight) Expanded(
            child: isEditable ? DropdownButtonFormField<String>(
              value: weightUnit, // Default value
              items: const [
                DropdownMenuItem(value: '', child: Text('weight')),
                DropdownMenuItem(value: 'lbs', child: Text('lbs')),
                DropdownMenuItem(value: 'kgs', child: Text('kgs')),
              ],
              onChanged: (value) { 
                if (onWeightUnitChanged != null) { 
                  onWeightUnitChanged!(value); 
                } 
              }
            ) : Text(
                    weightUnit, 
                    style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

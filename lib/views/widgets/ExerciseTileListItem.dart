import 'package:flutter/material.dart';

class ExerciseTileListItem extends StatelessWidget { // this is the line of sets, called in ExerciseTile
  final int setNumber;
  final TextEditingController repsController;
  final TextEditingController weightController;
  final ValueChanged<String?>? onUnitChanged;
  final ValueChanged<String> onRepsChanged; 
  final ValueChanged<String> onWeightChanged;
  final bool isEditable;
  final String unit;

  const ExerciseTileListItem({
    super.key,
    required this.setNumber,
    required this.repsController,
    required this.weightController,
    required this.onUnitChanged,
    required this.isEditable,
    required this.unit,
    required this.onRepsChanged,
    required this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text('$setNumber. '),
          Expanded(
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
          const SizedBox(width: 16),
          Expanded(
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
          Expanded(
            child: isEditable ? DropdownButtonFormField(
              value: 'lbs', // Default value
              items: const [
                DropdownMenuItem(value: 'lbs', child: Text('lbs')),
                DropdownMenuItem(value: 'kgs', child: Text('kgs')),
              ],
              onChanged: onUnitChanged,
            ) : Text(
                    unit, 
                    style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

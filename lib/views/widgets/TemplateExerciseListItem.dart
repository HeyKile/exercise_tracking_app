import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/ExerciseModel.dart';
import '../../models/TemplateModel.dart';

class TemplateExerciseListItem {
  Exercise exercise;
  bool isExpanded;
  List<Widget> setRows = [];
  List<List<TextEditingController>> controllers = [];

  TemplateExerciseListItem({
    required this.exercise,
    required this.isExpanded
  });

  factory TemplateExerciseListItem.fromSet(Exercise exercise, Exercise templateExercise) {
    TemplateExerciseListItem item = TemplateExerciseListItem(
      exercise: exercise,
      isExpanded: templateExercise.sets.isNotEmpty
    );
    return item;
  }

  addSet() {
    List<TextEditingController> rowControllers = exercise.trackedStats.map((stat) => TextEditingController()).toList();
    controllers.add(rowControllers);
    
    setRows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: exercise.trackedStats.asMap().entries.map((entry) {
          int index = entry.key;
          var stat = entry.value;
          List<Widget> statWidgets = [
            Text(
              stat.display,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 60.0,
              height: 35.0,
              child: TextField(
                controller: rowControllers[index],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
          ];
          if (stat.unit != null) {
            statWidgets.addAll([
              const SizedBox(width: 10.0),
              Text(
                stat.unit ?? "",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ]);
          }
          statWidgets.add(const SizedBox(width: 20.0));
          return Padding(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: statWidgets,
            ),
          );
        }).toList(),
      ),
    );
  }

  void removeSet(Widget setToRemove) {
    int index = setRows.indexOf(setToRemove);
    if (index != -1) {
      setRows.removeAt(index);
      controllers.removeAt(index);
    }
  }

  List<List<String>> getSetValues() {
    return controllers.map((rowControllers) => rowControllers.map((controller) => controller.text).toList()).toList();
  }
}
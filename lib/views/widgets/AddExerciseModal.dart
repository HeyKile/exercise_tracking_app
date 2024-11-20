import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/ExerciseModel.dart';
import '../../viewmodels/ExerciseViewModel.dart';

class AddExerciseModal extends StatefulWidget {
  const AddExerciseModal({super.key,});

  @override
  State<AddExerciseModal> createState() => _AddExerciseModalState();
}

class _AddExerciseModalState extends State<AddExerciseModal> {
  List<Exercise> selectedExercises = [];
  List<Exercise> currentExercises = [];
  TextEditingController searchController = TextEditingController();
  ExerciseTab _currentTab = ExerciseTab.allExercises;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    Provider.of<ExerciseViewModel>(context, listen: false).fetchExercises();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    Provider.of<ExerciseViewModel>(context, listen: false).getCurrentExercises(
      _currentTab,
      searchController.text
    );
  }

  void _onCreateExercise(context) async {
    bool hasDistance = false;
    bool hasReps = false;
    bool hasWeight = false;
    bool hasTime = false;

    TextEditingController nameController = TextEditingController();
    bool isButtonDisabled = true;

    var res = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SimpleDialog(
              title: const Text("Create new exercise"),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Exercise Name',
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      fillColor: Colors.transparent,
                      filled: true,
                      prefixIcon: Icon(Icons.create),
                    ),
                    cursorColor: Colors.black,
                    onChanged: (text) {
                      setState(() {
                        isButtonDisabled = text.isEmpty;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Text(
                            "Attributes",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ),
                      ),
                      CheckboxListTile(
                        contentPadding:const EdgeInsets.symmetric(horizontal: 50.0),
                        activeColor: Colors.blue,
                        title: const Text('Distance'),
                        value: hasDistance,
                        onChanged: (bool? value) {
                          setState(() {
                            hasDistance = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        contentPadding:const EdgeInsets.symmetric(horizontal: 50.0),
                        activeColor: Colors.blue,
                        title: const Text('Reps'),
                        value: hasReps,
                        onChanged: (bool? value) {
                          setState(() {
                            hasReps = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        contentPadding:const EdgeInsets.symmetric(horizontal: 50.0),
                        activeColor: Colors.blue,
                        title: const Text('Weight'),
                        value: hasWeight,
                        onChanged: (bool? value) {
                          setState(() {
                            hasWeight = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        contentPadding:const EdgeInsets.symmetric(horizontal: 50.0),
                        activeColor: Colors.blue,
                        title: const Text('Time'),
                        value: hasTime,
                        onChanged: (bool? value) {
                          setState(() {
                            hasTime = value ?? false;
                          });
                        },
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    onPressed: isButtonDisabled ? null : () {
                      Navigator.of(context).pop({
                        'name': nameController.text,
                        'hasDistance': hasDistance,
                        'hasReps': hasReps,
                        'hasWeight': hasWeight,
                        'hasTime': hasTime,
                      });
                    },
                    child: const Text('Create Exercise'),
                  ),
                ),
              ],
            );
          },
        );
      }
    );
    if (res != null) {
      setState(() {
        Provider.of<ExerciseViewModel>(context, listen: false).addCustomExercse(
          res['name'],
          res['hasDistance'],
          res['hasReps'],
          res['hasWeight'],
          res['hasTime']
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double tileWidth = width <= 1000
      ? width * 0.05
      : width * 0.1;
    
    Color enabledBackgroundColor = Colors.blue[400]!;
    Color disabledBackgroundColor = Colors.grey[100]!;
    Color enabledForegroundColor = Colors.black;
    Color disabledForegroundColor = Colors.black38;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          controller: searchController,
          style: const TextStyle(
            fontSize: 24,
          ),
          decoration: const InputDecoration(
            hintText: 'Search exercises',
            enabledBorder: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(),
            fillColor: Colors.transparent,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          cursorColor: Colors.black,
        ),
        surfaceTintColor: Colors.grey,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.05),
          child: Column(
            children: [
              SegmentedButton<ExerciseTab>(
                segments: const <ButtonSegment<ExerciseTab>>[
                  ButtonSegment(
                    value: ExerciseTab.allExercises,
                    label: Text('All Exercises')
                  ),
                  ButtonSegment(
                    value: ExerciseTab.customExercises,
                    label: Text('Custom Exercises')
                  ),
                ],
                selected: {_currentTab},
                onSelectionChanged: (Set<ExerciseTab> newSection) {
                  setState(() {
                    _currentTab = newSection.first;
                    _onSearchChanged();
                  });
                },
                showSelectedIcon: false,
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: const Color.fromARGB(200, 33, 150, 243),
                  selectedForegroundColor: Colors.black,
                  fixedSize: Size.fromWidth(width),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.12
                  )
                )
              ),
              const SizedBox(height: 10.0),
            ],
          )
        )
      ),
      body: Consumer<ExerciseViewModel>(
        builder: (context, exerciseViewModel, child) {
          List<Exercise> curExercises = exerciseViewModel.filteredExercises;

          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Visibility(
                visible: _currentTab == ExerciseTab.customExercises,
                child: ElevatedButton.icon(
                  label: const Text("Create New Exercise"),
                  icon: const Icon(Icons.create),
                  onPressed: () => _onCreateExercise(context),
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                      Colors.blue
                    )
                  ),
                )
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > 1000 ? 3 : 2,
                  ),
                  padding: EdgeInsets.only(
                    left: tileWidth,
                    right: tileWidth,
                    top: height * 0.01,
                    bottom: height * 0.2
                  ),
                  itemCount: curExercises.length,
                  itemBuilder: (context, index) {
                    final exercise = curExercises[index];
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
                )
              )
            ],
          );
        },
      ),
      floatingActionButton: selectedExercises.isNotEmpty
        ? FloatingActionButton(
            backgroundColor: selectedExercises.isEmpty
              ? disabledBackgroundColor
              : enabledBackgroundColor,
            foregroundColor: selectedExercises.isEmpty
              ? disabledForegroundColor
              : enabledForegroundColor,
            onPressed: selectedExercises.isEmpty
              ? null
              : () => Navigator.pop(context, selectedExercises),
            child: const Icon(Icons.check),
          )
        : null
    );
  }

}
import 'package:exercise_tracking_app/viewmodels/ExerciseViewModel.dart';
import 'package:exercise_tracking_app/viewmodels/TemplateViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/TemplateModel.dart';
import './widgets/AddExerciseModal.dart';
import './widgets/CustomRoundedExpansionTile.dart';
import './widgets/TemplateExerciseListItem.dart';

class TemplateBuilderView extends StatefulWidget {
  final Template? starterTemplate;

  const TemplateBuilderView({
    super.key,
    this.starterTemplate,
  });

  @override
  State<TemplateBuilderView> createState() => _TemplateBuilderViewState();
}

class _TemplateBuilderViewState extends State<TemplateBuilderView> {
  String title = "";
  TextEditingController titleController = TextEditingController();
  List<TemplateExerciseListItem> currentExercises = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController.addListener(_onTitleChanged);
    if (widget.starterTemplate != null) {
      title = widget.starterTemplate!.name;
      titleController.text = title;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExerciseViewModel>(context, listen: false).fetchExercises();
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void _onTitleChanged() {
    title = titleController.text;
  }

  void _showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Feature TBD...'),
      duration: Duration(seconds: 2)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _showAddExerciseModal(BuildContext context) async {
    final selectedExercises = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => ExerciseViewModel(),
          child: const AddExerciseModal(),
        )
      ),
    );
    if (selectedExercises != null && selectedExercises.length > 0) {
      setState(() {
        // currentExercises.addAll(selectedExercises);
        selectedExercises.forEach((exercise) {
          currentExercises.add(
            TemplateExerciseListItem(
              exercise: exercise,
              isExpanded: true
            )
          );
        });
      });
    }
  }

  void _onRemoveExerciseButtonClicked(BuildContext context, TemplateExerciseListItem exerciseItem) {
    var snackBar = SnackBar(
      content: Text('removing ${exerciseItem.exercise.name}'),
      duration: const Duration(seconds: 2)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      currentExercises.removeWhere((exercise) => exercise == exerciseItem);
    });
  }

  Future<void> _onSaveTemplateButtonClicked(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    // show loading spinner
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // save template
    bool result = await Provider.of<TemplateViewModel>(context, listen: false).saveTemplate(title, currentExercises);
    // hide loading spinner
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    // if success, show & naviagte back to template list
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Template Saved!'),
          duration: Duration(seconds: 2),
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      print("done lil bro");
      Navigator.pop(context);
    }
    // else, display error
    else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Color enabledBackgroundColor = Colors.green[400]!;
    Color disabledBackgroundColor = Colors.green[100]!;
    Color enabledForegroundColor = Colors.black;
    Color disabledForegroundColor = Colors.black38;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: SizedBox(
          width: width * 0.8,
          child: TextField(
            controller: titleController,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: 'New Custom Workout',
              contentPadding: const EdgeInsets.only(left: 10.0, bottom: -4.5),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),        
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _showSnackBar(context),
            icon: const Icon(Icons.tag),
            label: const Text(
              'Tags',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: width * 0.80,
              child: TextButton.icon(
                onPressed: () => _showAddExerciseModal(context),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Exercise',
                  style: TextStyle(
                    fontSize: 20.0
                  )
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentExercises.length,
              itemBuilder: (context, index) {
                final exerciseItem = currentExercises[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: CustomRoundedExpansionTile(
                    tileColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    duration: const Duration(milliseconds: 50),
                    leading: const Icon(Icons.chevron_left_rounded),
                    trailing: IconButton(
                      onPressed: () => _onRemoveExerciseButtonClicked(context, exerciseItem),
                      icon: const Icon(Icons.highlight_remove_rounded)
                    ),
                    isExpanded: exerciseItem.isExpanded,
                    title: Text(exerciseItem.exercise.name),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 6.0, right: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: const Border(
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                          child: Column(
                            children: [
                              ...exerciseItem.setRows.map((setRow) {
                                return Row(
                                  children: [
                                    Expanded(child: setRow),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          exerciseItem.removeSet(setRow);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              }),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    exerciseItem.addSet();
                                  });
                                },
                                child: const Text("Add Set")
                              )
                            ],
                          )
                        )
                      )
                    ]
                  )
                );
              }
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: currentExercises.isEmpty || _isLoading
          ? null
          : () => _onSaveTemplateButtonClicked(context),
        label: const Text('Save Template'),
        icon: const Icon(Icons.save_alt_outlined),
        backgroundColor: currentExercises.isEmpty || _isLoading
          ? disabledBackgroundColor
          : enabledBackgroundColor,
        foregroundColor: currentExercises.isEmpty || _isLoading
          ? disabledForegroundColor
          : enabledForegroundColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

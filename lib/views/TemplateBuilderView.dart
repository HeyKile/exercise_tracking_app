import 'package:exercise_tracking_app/viewmodels/ExerciseViewModel.dart';
import 'package:exercise_tracking_app/viewmodels/TemplateViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ExerciseModel.dart';
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
  TemplateIcon curIcon = TemplateIcon.person;

  @override
  void initState() {
    super.initState();
    titleController.addListener(_onTitleChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExerciseViewModel>(context, listen: false).fetchExercises();
    });
    _initializeTemplate();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<void> _initializeTemplate() async {
    if (widget.starterTemplate != null) {
      title = widget.starterTemplate!.name;
      titleController.text = title;
      currentExercises = await Future.wait(widget.starterTemplate!.exercises.map((templateExercise) async {
        Exercise? exercise = await Provider.of<ExerciseViewModel>(context, listen: false).getExerciseById(templateExercise.id);
        return TemplateExerciseListItem.fromSet(exercise!, templateExercise);
      }).toList());
      setState(() {});
    }
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
        builder: (context) => ChangeNotifierProvider.value(
          value: Provider.of<ExerciseViewModel>(context, listen: false),
          child: const AddExerciseModal(),
        ),
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
    bool result = await Provider.of<TemplateViewModel>(context, listen: false).saveTemplate(title, currentExercises, curIcon);
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

  void _onSelectIcon(context) async {
    var newIcon = await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: TemplateIcon.values.map((icon) {
                    return ListTile(
                      leading: Icon(icon.getIcon()),
                      title: Text(icon.toString().split('.').last),
                      onTap: () {
                        Navigator.pop(context, icon);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ]
        );
      }
    );
    if (newIcon != null) {
      setState(() => curIcon = newIcon);
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
        elevation: 9.0,
        toolbarHeight: 80.0,
        title: SizedBox(
          width: width * 0.8,
          child: TextField(
            controller: titleController,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'Template Name',
              enabledBorder: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(),
              fillColor: Colors.transparent,
              filled: true,
              prefixIcon: Icon(Icons.edit_outlined),
            ),
            cursorColor: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
                child: TextButton.icon(
                  onPressed: () => _onSelectIcon(context),
                  icon: Icon(curIcon.getIcon()),
                  label: const Text("Select Icon"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
                child: TextButton.icon(
                  onPressed: () => _showSnackBar(context),
                  icon: const Icon(Icons.more),
                  label: const Text("Tags"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => print("hi"),
            icon: const Icon(Icons.more_vert),
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
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
              child: ElevatedButton.icon(
                onPressed: () => _showAddExerciseModal(context),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  shadowColor: Colors.grey
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
                    boxDecoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2.0,
                          color: Colors.blue[800]!.withOpacity(0.4)
                        ),
                        right: BorderSide(
                          width: 2.0,
                          color: Colors.blue[800]!.withOpacity(0.4)
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.zero,
                        topRight: Radius.circular(10.0)
                      ),
                    ),
                    duration: const Duration(milliseconds: 50),
                    leading: const Icon(Icons.chevron_left_rounded),
                    trailing: IconButton(
                      onPressed: () => _onRemoveExerciseButtonClicked(context, exerciseItem),
                      icon: const Icon(Icons.highlight_remove_rounded)
                    ),
                    isExpanded: exerciseItem.isExpanded,
                    title: Text(
                      exerciseItem.exercise.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 6.0, right: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border(
                            right: BorderSide(color: Colors.grey[700]!.withOpacity(0.35)),
                            bottom: BorderSide(color: Colors.grey[700]!.withOpacity(0.35)),
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.zero,
                            topRight: Radius.zero
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                          child: Column(
                            children: [
                              ...exerciseItem.setRows.map((setRow) {
                                return Container(
                                  decoration:  BoxDecoration(
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
                                        child: setRow
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            exerciseItem.removeSet(setRow);
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                );
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      exerciseItem.addSet();
                                    });
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
                                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                                    shadowColor: WidgetStatePropertyAll<Color>(Colors.grey),
                                  ),
                                  child: const Text("Add Set"),
                                )
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

import 'package:exercise_tracking_app/views/widgets/TemplateListItem.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/TemplateViewModel.dart';
import '../../models/TemplateModel.dart';
import 'package:provider/provider.dart';
import '../TemplateBuilderView.dart';
import '../../viewmodels/ExerciseViewModel.dart';

enum TemplateTab { myTemplates, premade }

class TemplateList extends StatefulWidget {
  final bool isWorkout;
  final Function(Template?) chooseTemplate;

  const TemplateList({
    super.key,
    required this.isWorkout,
    required this.chooseTemplate
  });


  @override
  State<TemplateList> createState() => _TemplateListState();
}

class _TemplateListState extends State<TemplateList> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TemplateViewModel>(context, listen: false).fetchTemplates();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final templateViewModel = Provider.of<TemplateViewModel>(context, listen: false);
    templateViewModel.setSearchQuery(searchController.text);
  }

  VoidCallback chooseTemplate(Template? template) {
      return (){if (template == null) {
        print("Selected null!");
      }
      else {
        print('Selected ${template}');
      }
      widget.chooseTemplate(template);};
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TemplateViewModel>(
      builder: (context, templateViewModel, child) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search templates',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SegmentedButton<TemplateTab>(
                    segments: const <ButtonSegment<TemplateTab>>[
                      ButtonSegment<TemplateTab>(
                        value: TemplateTab.myTemplates,
                        label: Text('My Templates'),
                      ),
                      ButtonSegment<TemplateTab>(
                        value: TemplateTab.premade,
                        label: Text('Premade Templates'),
                      )
                    ],
                    selected: {templateViewModel.currentTab},
                    onSelectionChanged: (Set<TemplateTab> newSelection) {
                      templateViewModel.setTab(newSelection.first);
                    },
                    showSelectedIcon: false,
                    style: SegmentedButton.styleFrom(
                      selectedBackgroundColor: const Color.fromARGB(200, 33, 150, 243),
                      selectedForegroundColor: Colors.black,
                    )
                  )
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: widget.isWorkout,
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextButton(
                        onPressed: chooseTemplate(null),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 48, 168, 48),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add),
                            Text("Use Blank Template"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: templateViewModel.filteredTemplates.isNotEmpty
                    ? ListView.builder(
                        itemCount: templateViewModel.filteredTemplates.length,
                        itemBuilder: (context, idx) {
                          final template = templateViewModel.filteredTemplates[idx];
                          return TemplateListItem(
                            template: template,
                            onTap: chooseTemplate(template),
                            isWorkout: widget.isWorkout,
                          );
                        }
                      )
                    : const Text('No Templates Found')
                ),
              ],
            )
          ),
          floatingActionButton: Visibility(
            visible: !widget.isWorkout,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(value: templateViewModel),
                        ChangeNotifierProvider.value(value: Provider.of<ExerciseViewModel>(context, listen: false))
                      ],
                      child: const TemplateBuilderView(),
                    )
                  ),
                );
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      }
    );
  }
}
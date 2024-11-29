
import 'package:flutter/material.dart';
import '../models/TemplateModel.dart';
import '../services/TemplateService.dart';
import '../views/widgets/TemplateExerciseListItem.dart';
import '../views/widgets/TemplateList.dart';

class TemplateViewModel extends ChangeNotifier {
  List<Template> _allTemplates = <Template>[];
  int _highestTemplateId = -1;
  List<Template> _myTemplates = <Template>[];
  List<Template> _premadeTemplates = <Template>[];
  List<Template> filteredTemplates = <Template>[];
  final TemplateService _templateService = TemplateService();

  TemplateTab _currentTab = TemplateTab.myTemplates;
  String _searchQuery = '';

  TemplateTab get currentTab => _currentTab;
  String get searchQuery => _searchQuery;
  List<Template> get allTemplates => _allTemplates;

  Future<void> fetchTemplates() async {
    if (_allTemplates.isEmpty) {
      _allTemplates = await _templateService.createMockTemplates();
    }
    _highestTemplateId = _getHighestTemplateId();
    _myTemplates = getMyTemplates();
    _premadeTemplates = getPremadeTemplates();
    _updateFilteredTemplates();
    notifyListeners();
  }

  Future<bool> saveTemplate(String title, List<TemplateExerciseListItem> exercises) async {
    if (_highestTemplateId == -1) {
      await fetchTemplates();
    }
    try {
      Template newTemplate = _toTemplate(title, exercises);
      _allTemplates.add(newTemplate);
      await fetchTemplates();
      return true;
    }
    catch (_) {
      return false;
    }
  }

  List<Template> getSearchedTemplates(String searchQuery) {
    if (searchQuery == "") {
      return _allTemplates;
    }
    else {
      return _allTemplates
          .where((template) => template.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  void refreshTemplates() async {
    await fetchTemplates();
  }

  void setTab(TemplateTab tab) {
    _currentTab = tab;
    _updateFilteredTemplates();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _updateFilteredTemplates();
    notifyListeners();
  }

  void _updateFilteredTemplates() {
    List<Template> templates = _currentTab == TemplateTab.myTemplates
        ? _myTemplates
        : _premadeTemplates;

    if (_searchQuery.isEmpty) {
      filteredTemplates = templates;
    }
    else {
      filteredTemplates = templates
          .where((template) => template.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  int _getHighestTemplateId() {
    return _allTemplates.reduce((cur, next) => cur.id > next.id ? cur : next).id;
  }

  List<Template> getMyTemplates() {
    return _allTemplates
      .where((template) => template.isPremade == false)
      .toList();
  }

  List<Template> getPremadeTemplates() {
    return _allTemplates
      .where((template) => template.isPremade == true)
      .toList();
  }

  Map<String, dynamic> _templateToJsonObj(String title, List<TemplateExerciseListItem> exercises) {
    Map<String, dynamic> templateJson = {
      "id": _highestTemplateId + 1,
      "name": title,
      "isPremade": false,
      "exercises": exercises.map((exerciseItem) {
        return {
          "id": exerciseItem.exercise.id,
          "name": exerciseItem.exercise.name,
          "sets": exerciseItem.getSetValues().map((set) {
            Map<String, dynamic> setJson = {};
            for (int i = 0; i < set.length; i++) {
              var stat = exerciseItem.exercise.trackedStats[i];
              print(stat.display);
              print(stat.type.toString().split('.').last.toLowerCase());
              print(set[i]);
              if (set[i] != "") {
                setJson[stat.type.toString().split('.').last.toLowerCase()] = int.parse(set[i]);
              }
            }
            return setJson;
          }).toList()
        };
      }).toList()
    };
    return templateJson;
  }

  Template _toTemplate(String title, List<TemplateExerciseListItem> exercises) {
    return Template(
      id: _highestTemplateId + 1,
      name: title,
      isPremade: false,
      exercises: exercises.map((exerciseItem) {
        return TemplateExercise(
          id: exerciseItem.exercise.id,
          name: exerciseItem.exercise.name,
          sets: exerciseItem.getSetValues().map((curSet) {
            Map<String, dynamic> setJson = {};
            for (int i = 0; i < curSet.length; i++) {
              var stat = exerciseItem.exercise.trackedStats[i];
              if (curSet[i] != "") {
                setJson[stat.type.toString().split('.').last.toLowerCase()] = int.parse(curSet[i]);
              }
            }
          }).toList()
        );
      }).toList()
    );
  }
}
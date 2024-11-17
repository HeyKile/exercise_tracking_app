import 'dart:convert';

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

  Future<void> fetchTemplates() async {
    print("fetching this shish");
    _allTemplates = await _templateService.fetchTemplates();
    if (_allTemplates.isNotEmpty) {
      _highestTemplateId = _getHighestTemplateId();
      _myTemplates = getMyTemplates();
      _premadeTemplates = getPremadeTemplates();
      _updateFilteredTemplates();
    }
    print('got:');
    for (var t in _allTemplates) {
      print(t.name);
    }
    notifyListeners();
  }

  Future<bool> saveTemplate(String title, List<TemplateExerciseListItem> exercises) async {
    if (_highestTemplateId == -1) {
      await fetchTemplates();
    }
    Map jsonRes = _templateToJsonObj(title, exercises);
    bool res = await _templateService.saveTemplate(jsonRes);
    if (res == true) {
      refreshTemplates();
    }
    notifyListeners();
    return res;
  }

  void refreshTemplates() {
    fetchTemplates();
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
    print('highedt id: $_highestTemplateId');
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
}
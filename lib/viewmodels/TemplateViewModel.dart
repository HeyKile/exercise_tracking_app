import 'package:flutter/material.dart';
import '../models/TemplateModel.dart';
import '../services/TemplateService.dart';
import '../views/widgets/TemplateList.dart';

class TemplateViewModel extends ChangeNotifier {
  List<Template> _allTemplates = <Template>[];
  List<Template> _myTemplates = <Template>[];
  List<Template> _premadeTemplates = <Template>[];
  List<Template> filteredTemplates = <Template>[];
  final TemplateService _templateService = TemplateService();

  TemplateTab _currentTab = TemplateTab.myTemplates;
  String _searchQuery = '';

  TemplateTab get currentTab => _currentTab;
  String get searchQuery => _searchQuery;

  Future<void> fetchTemplates() async {
    _allTemplates = await _templateService.fetchTemplates();
    _myTemplates = getMyTemplates();
    _premadeTemplates = getPremadeTemplates();
    _updateFilteredTemplates();
    notifyListeners();
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
}
import 'dart:convert';
import 'dart:io';
import '../models/TemplateModel.dart';

class TemplateService {

  Future<List<Template>> fetchTemplates() async {
    try {
      String filePath = 'lib/data/templates.json';
      File file = File(filePath);
      String fileContent = await file.readAsString();
      try {
        List<dynamic> jsonList = jsonDecode(fileContent);
        List<Template> templates = jsonList.map((json) => Template.fromJson(json)).toList();
        return templates;
      }
      catch (_) {
        return [];
      }
    }
    catch (e) {
      print('Error reading file: $e');
      return [];
    }
  }

  Future<bool> saveTemplate(Map<dynamic, dynamic> newTemplateJson) async {
    try {
      String filePath = 'lib/data/templates.json';
      File file = File(filePath);
      String fileContent = await file.readAsString();
      List<dynamic> jsonTemplatesList;
      try {
        jsonTemplatesList = jsonDecode(fileContent);
      }
      catch (_) {
        jsonTemplatesList = [];
      }
      jsonTemplatesList.add(newTemplateJson);
      String updatedJson = jsonEncode(jsonTemplatesList);
      await file.writeAsString(updatedJson);
      return true;
    }
    catch (e) {
      print('Error saving the template: $e');
      return false;
    }
  }

}
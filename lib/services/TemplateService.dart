import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '../models/TemplateModel.dart';

class TemplateService {

  Future<List<Template>> fetchTemplates() async {
    try {
      String filePath = 'lib/data/templates.json';
      File file = File(filePath);
      String fileContent = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(fileContent);
      List<Template> templates = jsonList.map((json) => Template.fromJson(json)).toList();
      return templates;
    }
    catch (e) {
      print('Error reading or parsing the file: $e');
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
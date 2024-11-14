import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import '../models/TemplateModel.dart';

class TemplateService {

  Future<List<Template>> fetchTemplates() async {
    try {
      String fileContent = await rootBundle.loadString('lib/data/templates.json');
      List<dynamic> jsonList = jsonDecode(fileContent);
      List<Template> templates = jsonList.map((json) => Template.fromJson(json)).toList();
      return templates;
    }
    catch (e) {
      print('Error reading or parsing the file: $e');
      return [];
    }
  }

}
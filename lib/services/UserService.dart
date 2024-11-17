import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import '../models/UserModel.dart';

class UserService {

  Future<List<User>> fetchTemplates() async {
    try {
      String fileContent = await rootBundle.loadString('lib/data/user.json');
      List<dynamic> jsonList = jsonDecode(fileContent);
      List<User> user = jsonList.map((json) => User.fromJson(json)).toList();
      return user;
    }
    catch (e) {
      print('Error reading or parsing the file: $e');
      return [User(name: '', achievements: [], goals:[])];
    }
  }

}
import 'package:flutter/material.dart';
import '../models/UserModel.dart';
import '../services/UserService.dart';
import '../views/HomeView.dart';

class UserViewModel extends ChangeNotifier {
  List<User> _user = <User>[User(name:"", achievements: [], goals: [])];//User(name:"", achievements: [], goals: []);
  String _userName = '';
  List<Achievement> _userAchievements = <Achievement>[];
  List<Goal> _userGoals = <Goal>[];

  final UserService _userService = UserService();

  Future<void> fetchUser() async {
    _user = await _userService.fetchTemplates();
    _userName = getUser();
    _userAchievements = getUserAchievements();
    _userGoals = getUserGoals();
    notifyListeners();
  }

  String getUser() {
    return _user[0].name;
  }

  List<Achievement> getUserAchievements() {
    return _user[0].achievements;
  }

  List<Goal> getUserGoals() {
    return _user[0].goals;
  }
}
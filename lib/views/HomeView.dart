import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/UserViewModel.dart';
import 'widgets/HomeWidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: ChangeNotifierProvider(
          create: (_) => UserViewModel(),
          child: const HomeWidget(),
        ),
      ),
    );
  }
}
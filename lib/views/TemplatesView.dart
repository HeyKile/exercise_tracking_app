import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/TemplateViewModel.dart';
import 'widgets/TemplateList.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateList(isWorkout: false),
    );
  }
}
import 'package:flutter/material.dart';
import 'widgets/TemplateList.dart';
import '../../models/TemplateModel.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateList(isWorkout: false, chooseTemplate: (Template? template){},),
    );
  }
}
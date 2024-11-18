import 'package:flutter/material.dart';
import '../../models/ExerciseModel.dart';

class AddExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Image? image;

  const AddExerciseCard({
    super.key,
    required this.exercise,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          image == null
            ? const Icon(Icons.image_outlined)
            : image!
        ],
      ),
    );
  }
}
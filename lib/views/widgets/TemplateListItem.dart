import 'package:flutter/material.dart';
import '../../models/TemplateModel.dart';

class TemplateListItem extends StatelessWidget {
  final Template template;
  final VoidCallback onTap;
  final bool isWorkout;
  
  const TemplateListItem({
    super.key,
    required this.template,
    required this.onTap,
    required this.isWorkout,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double horizontalPadding = width * 0.02;
    double height = MediaQuery.of(context).size.height;
    double verticalPadding = height * 0.02;

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: verticalPadding),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: width * 0.80,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  template.icon.getIcon(),
                  size: 50.0,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('${template.exercises.length} Sets'),
                    const SizedBox(height: 8),
                  ],
                ),
                const Spacer(),
                Visibility(
                  visible: isWorkout,
                  child: const Icon(
                    Icons.check,
                    size: 24.0,
                  )
                ),
                Visibility(
                  visible: !isWorkout,
                  child: const Icon(
                    Icons.chevron_right,
                    size: 24.0,
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
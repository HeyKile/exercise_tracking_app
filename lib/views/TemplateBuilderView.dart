import 'package:flutter/material.dart';

class TemplateBuilderView extends StatelessWidget {
  const TemplateBuilderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template Builder'),
      ),
      body: const Center(
        child: Text('Back to Templates')
      ),
    );
  }
}
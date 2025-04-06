import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isOptional;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: isOptional ? '$labelText (Optional)' : labelText,
        labelStyle: const TextStyle(color: Colors.cyan),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.cyan, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}

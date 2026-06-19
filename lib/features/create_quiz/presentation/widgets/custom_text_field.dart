import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    this.label,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // Matching the rounded corners in Figma
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 15 : 30),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 15 : 30),
              borderSide: const BorderSide(color: Colors.blueAccent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 15 : 30),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 15 : 30),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

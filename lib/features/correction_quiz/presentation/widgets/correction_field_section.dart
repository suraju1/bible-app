import 'package:flutter/material.dart';

class CorrectionFieldSection extends StatefulWidget {
  final String title;
  final String currentValue;
  final TextEditingController correctionController;
  final Function(bool isCorrect) onValidationChanged;

  const CorrectionFieldSection({
    super.key,
    required this.title,
    required this.currentValue,
    required this.correctionController,
    required this.onValidationChanged,
  });

  @override
  State<CorrectionFieldSection> createState() => _CorrectionFieldSectionState();
}

class _CorrectionFieldSectionState extends State<CorrectionFieldSection> {
  bool? _isCorrect; // null means no selection yet

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100, // Very light grey container mimicking Figma
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Value
              Text(
                'Current',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  widget.currentValue,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),

              // Validation Toggles
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() => _isCorrect = true);
                      widget.onValidationChanged(true);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Correct',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _isCorrect == true ? Colors.green : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.check,
                          size: 16,
                          color: _isCorrect == true ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  InkWell(
                    onTap: () {
                      setState(() => _isCorrect = false);
                      widget.onValidationChanged(false);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Incorrect',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _isCorrect == false ? Colors.red : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.close,
                          size: 16,
                          color: _isCorrect == false ? Colors.red : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),

              // Correction Box
              Text(
                'Correction',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: widget.correctionController,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    hintText: 'Enter correction...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

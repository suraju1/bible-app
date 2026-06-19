import 'package:flutter/material.dart';

class StatisticCardWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final int value;
  final String label;

  const StatisticCardWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8EFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF4A76A8).withOpacity(0.5),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 8),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A76A8),
            ),
          ),
        ],
      ),
    );
  }
}

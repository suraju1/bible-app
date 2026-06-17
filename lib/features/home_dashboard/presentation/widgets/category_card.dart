import 'package:flutter/material.dart';
import 'category_illustrations.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String iconType;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.iconType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF01369F).withValues(alpha: 0.15), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Content Layout
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Category Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF01369F), // Deep blue color matching Figma
                    height: 1.2,
                  ),
                ),

                // Bottom row with Arrow and Illustration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Arrow Button with Gradient
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF5A84C3), Color(0xFF01369F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_outward, // ↗ arrow icon
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),

                    // Placeholder/Illustration container
                    const SizedBox(width: 4),
                  ],
                ),
              ],
            ),
          ),

          // Positioned Illustration on bottom right
          Positioned(
            right: 4,
            bottom: 4,
            width: 75,
            height: 75,
            child: IgnorePointer(
              child: _buildIllustration(),
            ),
          ),

          // Flat transparent InkWell for click handling
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    switch (iconType) {
      case 'live_quiz':
        return const CustomPaint(
          painter: PencilsIllustrationPainter(),
        );
      case 'discipline_challenge':
        return const CustomPaint(
          painter: MindPuzzleIllustrationPainter(),
        );
      default:
        return Container();
    }
  }
}

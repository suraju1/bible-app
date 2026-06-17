import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final VoidCallback onStart;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.progress,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 225, // Height adjusted to 225 to prevent overflows and provide perfect spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF01369F), // Dark blue
            Color(0xFFA6A6A6), // Grey
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF01369F).withValues(alpha: 0.25),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Glowing Swirls
          const Positioned.fill(
            child: CustomPaint(
              painter: ChallengeCardBackgroundPainter(),
            ),
          ),

          // Meditating Silhouette Illustration
          Positioned(
            right: -10, // Align exactly as in Figma
            bottom: 0,
            top: 20,
            width: 175,
            child: Image.asset(
              'assets/images/think_better_card_image.png',
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title & Description Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),

                // Progress Info & Action Button Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress text
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Progress Bar Capsule
                    Container(
                      width: 120,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress.clamp(0.12, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF01369F),
                                    Color(0xFFA6A6A6),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF01369F).withValues(alpha: 0.3),
                                    blurRadius: 3,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Start Action Button
                    GestureDetector(
                      onTap: onStart,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Start Quiz',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChallengeCardBackgroundPainter extends CustomPainter {
  const ChallengeCardBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final path1 = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.3, size.height * 0.3,
        size.width * 0.6, size.height * 0.1,
      );

    canvas.drawPath(path1, paint1);

    final paint2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    canvas.save();
    canvas.translate(size.width * 0.42, size.height * 0.35);
    canvas.rotate(-0.4);
    final rect2 = Rect.fromCenter(center: Offset.zero, width: 160, height: 100);
    canvas.drawOval(rect2, paint2);
    canvas.restore();

    final paint3 = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.save();
    canvas.translate(size.width * 0.45, size.height * 0.38);
    final rect3 = Rect.fromCenter(center: Offset.zero, width: 100, height: 100);
    canvas.drawOval(rect3, paint3);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

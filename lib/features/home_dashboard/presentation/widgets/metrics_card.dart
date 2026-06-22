import 'package:flutter/material.dart';

class MetricsCard extends StatelessWidget {
  final int dailyStreak;
  final int rank;
  final int level;
  final double levelProgress;
  final int points;

  const MetricsCard({
    super.key,
    required this.dailyStreak,
    required this.rank,
    required this.level,
    required this.levelProgress,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MetricsCardShapePainter(
        borderColor: const Color(0xFF01369F).withValues(alpha: 0.15),
        shadowColor: const Color(0xFF01369F).withValues(alpha: 0.08),
      ),
      child: Container(
        width: double.infinity,
        // 26 is the tab height, 20 is the visual padding below the tab
        padding: const EdgeInsets.only(left: 16, right: 16, top: 26 + 20, bottom: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Row of Stats
            Row(
              children: [
                // Rank Column
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Rank',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _getRankAsset(_getRankName(level)),
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              _getRankName(level),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Divider 1
                Container(
                  height: 40,
                  width: 1.5,
                  color: const Color(0xFF01369F).withValues(alpha: 0.2),
                ),

                // Level Column
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Level',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$level',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Progress Bar
                      Container(
                        width: 65,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: levelProgress.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF5A84C3), Color(0xFF01369F)],
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider 2
                Container(
                  height: 40,
                  width: 1.5,
                  color: const Color(0xFF01369F).withValues(alpha: 0.2),
                ),

                // Points Column
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Points',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Shiny Gold Coin
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withValues(alpha: 0.3),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.monetization_on,
                              color: Color(0xFFFFD700), // Pure Gold
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$points',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Daily Streak Text centered inside the tab
            Positioned(
              // Centered in the top tab
              top: -33,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Daily Streak : ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '$dailyStreak',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRankName(int currentLevel) {
    if (currentLevel >= 100) return 'Legend';
    if (currentLevel >= 80) return 'Champion';
    if (currentLevel >= 70) return 'Elite';
    if (currentLevel >= 60) return 'Grand Master';
    if (currentLevel >= 50) return 'Master';
    if (currentLevel >= 40) return 'Diamond';
    if (currentLevel >= 30) return 'Platinum';
    if (currentLevel >= 20) return 'Gold';
    if (currentLevel >= 10) return 'Silver';
    return 'Bronze';
  }

  String _getRankAsset(String rankName) {
    switch (rankName.toLowerCase()) {
      case 'bronze': return 'assets/images/bronze.png';
      case 'silver': return 'assets/images/silver.png';
      case 'gold': return 'assets/images/gold.png';
      case 'platinum': return 'assets/images/platinum.png';
      case 'diamond': return 'assets/images/dimond.png';
      case 'master': return 'assets/images/master.png';
      case 'grand master': return 'assets/images/grand_master.png';
      case 'elite': return 'assets/images/elite.png';
      case 'champion': return 'assets/images/champion.png';
      case 'legend': return 'assets/images/legend.png';
      default: return 'assets/images/bronze.png';
    }
  }
}

class MetricsCardShapePainter extends CustomPainter {
  final Color borderColor;
  final Color shadowColor;

  MetricsCardShapePainter({required this.borderColor, required this.shadowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final double w = size.width;
    final double h = size.height;
    const double tabH = 26.0;
    const double tabW = 140.0;
    const double r = 24.0; // Main card corner radius
    const double tr = 12.0; // Tab top corner radius
    const double br = 12.0; // Tab base junction radius (inward curve)

    final double tabStart = (w - tabW) / 2;
    final double tabEnd = (w + tabW) / 2;

    final path = Path()
      // Start at top-left corner (after the curve)
      ..moveTo(r, tabH)
      // Line to start of tab base junction
      ..lineTo(tabStart - br, tabH)
      // Curve up into the tab side
      ..quadraticBezierTo(tabStart, tabH, tabStart, tabH - br)
      // Line to tab top corner (before top curve)
      ..lineTo(tabStart, tr)
      // Curve to tab top
      ..quadraticBezierTo(tabStart, 0, tabStart + tr, 0)
      // Line to tab top-right (before top curve)
      ..lineTo(tabEnd - tr, 0)
      // Curve to tab top-right side
      ..quadraticBezierTo(tabEnd, 0, tabEnd, tr)
      // Line down to tab right base junction (before curve)
      ..lineTo(tabEnd, tabH - br)
      // Curve to card top
      ..quadraticBezierTo(tabEnd, tabH, tabEnd + br, tabH)
      // Line to top-right corner (before curve)
      ..lineTo(w - r, tabH)
      // Curve to right edge
      ..quadraticBezierTo(w, tabH, w, tabH + r)
      // Line down to bottom-right corner (before curve)
      ..lineTo(w, h - r)
      // Curve to bottom edge
      ..quadraticBezierTo(w, h, w - r, h)
      // Line to bottom-left corner (before curve)
      ..lineTo(r, h)
      // Curve to left edge
      ..quadraticBezierTo(0, h, 0, h - r)
      // Line up to top-left corner (before curve)
      ..lineTo(0, tabH + r)
      // Curve to top edge
      ..quadraticBezierTo(0, tabH, r, tabH)
      ..close();

    // Draw modern soft shadow
    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path.shift(const Offset(0, 6)), shadowPaint);

    // Draw card fill
    canvas.drawPath(path, paint);

    // Draw card border
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

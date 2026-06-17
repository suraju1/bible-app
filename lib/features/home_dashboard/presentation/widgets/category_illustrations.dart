import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Painter that draws two crossed pencils for "Live Quiz Mode"
class PencilsIllustrationPainter extends CustomPainter {
  const PencilsIllustrationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black38
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    // Draw Pencil 1 (slanted top-left to bottom-right)
    canvas.save();
    canvas.translate(size.width * 0.4, size.height * 0.4);
    canvas.rotate(math.pi / 4);
    _drawSinglePencil(canvas, const Size(12, 50), paint, fillPaint);
    canvas.restore();

    // Draw Pencil 2 (slanted top-right to bottom-left)
    canvas.save();
    canvas.translate(size.width * 0.6, size.height * 0.4);
    canvas.rotate(-math.pi / 4);
    _drawSinglePencil(canvas, const Size(12, 50), paint, fillPaint);
    canvas.restore();
  }

  void _drawSinglePencil(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Body rect
    final bodyPath = Path()
      ..moveTo(-w / 2, -h / 2)
      ..lineTo(w / 2, -h / 2)
      ..lineTo(w / 2, h / 2 - 10)
      ..lineTo(-w / 2, h / 2 - 10)
      ..close();
    canvas.drawPath(bodyPath, fill);
    canvas.drawPath(bodyPath, stroke);

    // Tip triangle
    final tipPath = Path()
      ..moveTo(-w / 2, h / 2 - 10)
      ..lineTo(w / 2, h / 2 - 10)
      ..lineTo(0, h / 2)
      ..close();
    canvas.drawPath(tipPath, fill);
    canvas.drawPath(tipPath, stroke);

    // Lead point
    final leadPath = Path()
      ..moveTo(-w / 4, h / 2 - 5)
      ..lineTo(w / 4, h / 2 - 5)
      ..lineTo(0, h / 2)
      ..close();
    final leadPaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;
    canvas.drawPath(leadPath, leadPaint);

    // Eraser on top
    final eraserPath = Path()
      ..moveTo(-w / 2, -h / 2)
      ..lineTo(w / 2, -h / 2)
      ..lineTo(w / 2, -h / 2 - 4)
      ..lineTo(-w / 2, -h / 2 - 4)
      ..close();
    final eraserPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.fill;
    canvas.drawPath(eraserPath, eraserPaint);
    canvas.drawPath(eraserPath, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter that draws a human head profile containing puzzle pieces for "Discipline Challenge"
class MindPuzzleIllustrationPainter extends CustomPainter {
  const MindPuzzleIllustrationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black38
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;

    // Draw Head Profile outline
    final headPath = Path()
      // Neck back
      ..moveTo(w * 0.25, h * 0.9)
      ..quadraticBezierTo(w * 0.2, h * 0.7, w * 0.25, h * 0.6)
      // Back of head (skull curve)
      ..cubicTo(w * 0.1, h * 0.5, w * 0.25, h * 0.15, w * 0.5, h * 0.15)
      // Forehead
      ..cubicTo(w * 0.7, h * 0.15, w * 0.75, h * 0.35, w * 0.75, h * 0.4)
      // Nose
      ..lineTo(w * 0.85, h * 0.45)
      ..lineTo(w * 0.78, h * 0.5)
      // Lips
      ..quadraticBezierTo(w * 0.82, h * 0.55, w * 0.76, h * 0.6)
      // Chin
      ..quadraticBezierTo(w * 0.8, h * 0.7, w * 0.7, h * 0.72)
      // Neck front
      ..lineTo(w * 0.65, h * 0.9);

    canvas.drawPath(headPath, paint);

    // Draw 3 puzzle pieces inside the head area
    final puzzlePaint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    // Draw a simplified puzzle-like square inside the brain area
    final r1 = Rect.fromLTWH(w * 0.35, h * 0.35, w * 0.15, h * 0.15);
    final r2 = Rect.fromLTWH(w * 0.51, h * 0.35, w * 0.15, h * 0.15);
    final r3 = Rect.fromLTWH(w * 0.43, h * 0.51, w * 0.15, h * 0.15);

    canvas.drawRect(r1, puzzlePaint);
    canvas.drawRect(r1, paint);
    canvas.drawRect(r2, puzzlePaint);
    canvas.drawRect(r2, paint);
    canvas.drawRect(r3, puzzlePaint);
    canvas.drawRect(r3, paint);

    // Add little connector dots to make them look like puzzle pieces
    canvas.drawCircle(Offset(w * 0.5, h * 0.425), 3, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.5, h * 0.425), 3, paint);
    canvas.drawCircle(Offset(w * 0.51, h * 0.585), 3, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.51, h * 0.585), 3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter that draws a silhouette of a person meditating in Lotus Position
class MeditationIllustrationPainter extends CustomPainter {
  const MeditationIllustrationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;

    // Center offset for the body
    final cx = w * 0.65;
    final cy = h * 0.55;

    // Head
    canvas.drawCircle(Offset(cx, cy - 25), 10, paint);
    canvas.drawCircle(Offset(cx, cy - 25), 10, strokePaint);

    // Neck
    final neckPath = Path()
      ..moveTo(cx - 2, cy - 15)
      ..lineTo(cx + 2, cy - 15)
      ..lineTo(cx + 2, cy - 12)
      ..lineTo(cx - 2, cy - 12)
      ..close();
    canvas.drawPath(neckPath, paint);

    // Torso & Legs (Lotus Pose)
    final bodyPath = Path()
      // Shoulder Left
      ..moveTo(cx - 16, cy - 10)
      // Shoulder Right
      ..lineTo(cx + 16, cy - 10)
      // Right Elbow/Arm
      ..quadraticBezierTo(cx + 25, cy + 5, cx + 18, cy + 15)
      // Right Knee
      ..lineTo(cx + 35, cy + 22)
      // Right foot
      ..quadraticBezierTo(cx + 25, cy + 28, cx + 10, cy + 24)
      // Left foot
      ..lineTo(cx - 10, cy + 24)
      // Left Knee
      ..quadraticBezierTo(cx - 25, cy + 28, cx - 35, cy + 22)
      // Left Elbow/Arm
      ..lineTo(cx - 18, cy + 15)
      ..quadraticBezierTo(cx - 25, cy + 5, cx - 16, cy - 10)
      ..close();

    canvas.drawPath(bodyPath, paint);
    canvas.drawPath(bodyPath, strokePaint);

    // Draw hands resting on knees (circles representing Gyan Mudra)
    canvas.drawCircle(Offset(cx - 24, cy + 16), 4, paint);
    canvas.drawCircle(Offset(cx - 24, cy + 16), 4, strokePaint);
    canvas.drawCircle(Offset(cx + 24, cy + 16), 4, paint);
    canvas.drawCircle(Offset(cx + 24, cy + 16), 4, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

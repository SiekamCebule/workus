import 'package:flutter/material.dart';

class CrossOutPainter extends CustomPainter {
  CrossOutPainter({
    required this.progress,
    required this.color,
    required this.lineHeight,
    this.preferredWidth,
    this.horizontalPadding = 5,
  });

  final double progress; // 0.0 to 1.0
  final Color color;
  final double lineHeight;
  final double? preferredWidth;
  final double horizontalPadding;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = lineHeight;

    final startX = progress > 0 ? (0.0 - horizontalPadding) : 0.0;
    final endX = (preferredWidth ?? size.width) * progress;
    final centerY = size.height / 2;
    canvas.drawLine(Offset(startX, centerY), Offset(endX, centerY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

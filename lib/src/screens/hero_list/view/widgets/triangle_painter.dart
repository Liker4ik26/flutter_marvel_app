import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  const TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paintTriangle = Paint()..color = color;

    final trianglePath = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, size.height - size.height / 2)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(trianglePath, paintTriangle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TriangleWidget extends StatelessWidget {
  const TriangleWidget({super.key, this.color = Colors.green});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: TrianglePainter(color: color),
    );
  }
}

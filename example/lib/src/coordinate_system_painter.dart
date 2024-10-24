import 'dart:math';

import 'package:flutter/material.dart';

enum _Axis {
  x,
  y,
  z;

  String get text => switch (this) {
        x => 'Roll',
        y => 'Pitch',
        z => 'Yaw',
      };
}

class CoordinateSystemPainter extends CustomPainter {
  const CoordinateSystemPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double side = size.shortestSide / 2;
    final Offset center = size.center(Offset.zero);

    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final Paint iconPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    _drawAxis(
      _Axis.x,
      canvas,
      paint,
      iconPaint,
      side: side,
      start: center,
      end: center - Offset(side, 0),
      arrowOffset1: const Offset(8, 8),
      arrowOffset2: const Offset(8, -8),
      arcStartAngle: pi - pi / 6,
      arcSweepAngle: -2 * pi + pi / 3,
      text: 'Roll',
    );

    _drawAxis(
      _Axis.y,
      canvas,
      paint,
      iconPaint,
      side: side,
      start: center,
      end: center + Offset(0, side),
      arrowOffset1: const Offset(-8, -8),
      arrowOffset2: const Offset(8, -8),
      arcStartAngle: pi - pi / 6,
      arcSweepAngle: -2 * pi + pi / 3,
      text: 'Pitch',
    );

    _drawAxis(
      _Axis.z,
      canvas,
      paint,
      iconPaint,
      side: side,
      start: center,
      end: center + Offset(0, side),
      arrowOffset1: const Offset(-8, -8),
      arrowOffset2: const Offset(8, -8),
      arcStartAngle: pi - pi / 6,
      arcSweepAngle: -2 * pi + pi / 3,
      text: 'Yaw',
    );

    final double cathetus = sqrt(side * side / 2);
    final Offset zAxisEnd = center + Offset(cathetus, -cathetus);
    canvas.drawLine(
      center,
      zAxisEnd,
      paint,
    );
    canvas.drawLine(
      zAxisEnd,
      zAxisEnd + const Offset(0, 12),
      paint,
    );
    canvas.drawLine(
      zAxisEnd,
      zAxisEnd - const Offset(12, 0),
      paint,
    );
  }

  void _drawAxis(
    _Axis axis,
    Canvas canvas,
    Paint paint,
    Paint iconPaint, {
    required double side,
    required Offset start,
    required Offset end,
    required Offset arrowOffset1,
    required Offset arrowOffset2,
    required double arcStartAngle,
    required double arcSweepAngle,
    required String text,
  }) {
    _drawLine(
      canvas,
      paint,
      from: start,
      to: end,
      arrowOffset1: arrowOffset1,
      arrowOffset2: arrowOffset2,
    );
    _drawArc(
      canvas,
      iconPaint,
      side: side,
      start: end,
      startAngle: arcStartAngle,
      sweepAngle: arcSweepAngle,
    );
    _paintText(
      canvas,
      text: text,
      maxWidth: side / 2,
      offset: Offset(
        end.dx + side / 4 + 16,
        end.dy - 64,
      ),
    );
  }

  void _drawLine(
    Canvas canvas,
    Paint paint, {
    required Offset from,
    required Offset to,
    required Offset arrowOffset1,
    required Offset arrowOffset2,
  }) {
    canvas.drawLine(
      from,
      to,
      paint,
    );
    canvas.drawLine(
      to,
      to + arrowOffset1,
      paint,
    );
    canvas.drawLine(
      to,
      to + arrowOffset2,
      paint,
    );
  }

  void _drawArc(
    Canvas canvas,
    Paint paint, {
    required double side,
    required Offset start,
    required double startAngle,
    required double sweepAngle,
  }) {
    const double yOffset = 40;
    const sideFactor = 0.25;

    final double xOffset = -side * sideFactor;

    canvas.drawArc(
      start - Offset(xOffset, yOffset) & const Size.square(32),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
    canvas.drawLine(
      start - Offset(xOffset - 3, yOffset - 7),
      start - Offset(xOffset - 6, yOffset + 2),
      paint,
    );
    canvas.drawLine(
      start - Offset(xOffset - 3, yOffset - 7),
      start - Offset(xOffset - 12, yOffset - 7),
      paint,
    );
  }

  void _paintText(
    Canvas canvas, {
    required String text,
    required double maxWidth,
    required Offset offset,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.orange,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: maxWidth,
    );

    textPainter.paint(
      canvas,
      offset -
          Offset(
                textPainter.width,
                textPainter.height,
              ) /
              2,
    );
  }

  @override
  bool shouldRepaint(CoordinateSystemPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CoordinateSystemPainter oldDelegate) => false;
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  double counter = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      print(timer.tick);
      counter += pi * 2 / 60;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.rotate(
          angle: counter,
          child: CustomPaint(
            size: const Size(300, 300),
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      100,
      paint,
    );

    final linePaint = Paint();
    linePaint.color = Colors.white;
    linePaint.style = PaintingStyle.stroke;
    linePaint.strokeWidth = 10;
    linePaint.strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.width / 2, size.height / 2 - 80);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

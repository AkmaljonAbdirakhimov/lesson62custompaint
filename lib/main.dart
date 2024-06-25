import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  // ui.Image? image;

  // @override
  // void initState() {
  //   super.initState();

  //   loadImage().then((_) {
  //     setState(() {});
  //   });
  // }

  // Future<void> loadImage() async {
  //   final ByteData data = await rootBundle.load("assets/image.png");
  //   final Uint8List bytes = data.buffer.asUint8List();
  //   final ui.Codec codec = await ui.instantiateImageCodec(bytes);
  //   final ui.FrameInfo frameInfo = await codec.getNextFrame();
  //   image = frameInfo.image;
  // }

  late AnimationController animationController;
  late Animation<Offset> animation;
  Offset oldPosition = Offset(0, 0);
  Offset newPosition = Offset(1, 1);

  Alignment alignment = Alignment.center;
  Duration animationDuration = Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    animation = Tween<Offset>(
      begin: oldPosition,
      end: newPosition,
    ).animate(animationController);

    animationController.forward();

    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        oldPosition = newPosition;
        newPosition = Offset(
          Random().nextDouble() * 1,
          Random().nextDouble() * 1,
        );

        animation = Tween<Offset>(
          begin: oldPosition,
          end: newPosition,
        ).animate(animationController);

        animationController.reset();
        animationController.forward();
      }
    });

    Future.delayed(Duration.zero, () {
      alignment = Alignment.bottomCenter;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AnimatedAlign(
          alignment: alignment,
          duration: animationDuration,
          onEnd: () {
            oldPosition = newPosition;
            newPosition = Offset(
              Random().nextDouble() * 100,
              Random().nextDouble() * 100,
            );
            double distance = sqrt(
              pow(newPosition.dx - oldPosition.dx, 2) +
                  pow(newPosition.dy - oldPosition.dy, 2),
            );
            double velocity = 100 / 1000; // Birlik/ms
            int duration = (distance / velocity).round(); // Millisoniya

            animationDuration = Duration(milliseconds: duration * 2);
            alignment = Alignment(newPosition.dx / 100, newPosition.dy / 100);
            setState(() {});
          },
          child: CustomPaint(
            painter: MyAnimatedCustomPainter(),
          ),
        ),
      ),
    );
  }
}

class MyAnimatedCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 200,
      height: 200,
    );

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter extends CustomPainter {
  final ui.Image? image;

  MyPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) async {
    // final paint = Paint();
    // paint.color = Colors.blue;
    // paint.style = PaintingStyle.stroke;
    // paint.strokeWidth = 5;

    // // Dumaloq shakl chizish
    // canvas.drawCircle(
    //   Offset(size.width / 2, size.height / 2),
    //   100,
    //   paint,
    // );

    // // Ellips chizish
    // final anotherPaint = Paint();
    // anotherPaint.color = Colors.red;
    // anotherPaint.style = PaintingStyle.stroke;
    // anotherPaint.strokeWidth = 5;

    // const oval = Rect.fromLTWH(50, 200, 200, 100);
    // canvas.drawOval(oval, anotherPaint);

    // // to'rtburchak chizish
    // final paintRect = Paint();
    // paintRect.color = Colors.amber;
    // paintRect.style = PaintingStyle.fill;

    // const rect = Rect.fromLTWH(50, 50, 200, 100);
    // canvas.drawRect(rect, paintRect);

    // yulduzcha chizish
    // final paintStar = Paint();
    // paintStar.color = Colors.purple;
    // paintStar.style = PaintingStyle.fill;
    // paintStar.strokeWidth = 5;

    // final path = Path();
    // path.moveTo(size.width / 2, size.height / 2 - 50);
    // path.lineTo(size.width / 2 + 30, size.height / 2 + 50);
    // path.lineTo(size.width / 2 - 45, size.height / 2 - 15);
    // path.lineTo(size.width / 2 + 45, size.height / 2 - 15);
    // path.lineTo(size.width / 2 - 30, size.height / 2 + 50);

    // path.close();
    // canvas.drawPath(path, paintStar);

    // // matn chizish
    // final textPainter = TextPainter(
    //   text: const TextSpan(
    //     text: "Salom, Flutter!",
    //     style: TextStyle(
    //       color: Colors.black,
    //       fontSize: 24,
    //     ),
    //   ),
    //   textDirection: TextDirection.ltr,
    // );

    // textPainter.layout(minWidth: 0, maxWidth: size.width);
    // const offset = Offset(50, 200);
    // textPainter.paint(canvas, offset);

    // const rect = Rect.fromLTWH(50, 50, 200, 100);
    // if (image != null) {
    //   // canvas.drawImage(image!, Offset.zero, Paint());
    //   paintImage(canvas: canvas, rect: rect, image: image!);
    // }
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.image != image;
  }
}

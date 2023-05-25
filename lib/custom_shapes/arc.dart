import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:polyrhythm_web/constants.dart';

class ArcPainter extends CustomPainter {
  ArcPainter({required this.index, required this.time, required this.audioPlayer});
  int index;
  double time;
  AudioPlayer audioPlayer;

  @override
  void paint(Canvas canvas, Size size) {
    var arcPaint = Paint();
    arcPaint.color = Colors.red;
    arcPaint.style = PaintingStyle.stroke;
    arcPaint.strokeWidth = 4.0;
    double degToRad(num deg) => deg * (math.pi / 180.0);

    var path = Path();
    path.moveTo(size.width / 4, ((size.height * 2) / 4));
    path.arcTo(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: (index * (size.width / 10)),
            height: (index * (size.width / 10))),
        degToRad(0),
        degToRad(-180),
        true);

    canvas.drawPath(path, arcPaint);

    var circlePaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    double angle = time * kAngularVelocites[index - 1];
    angle % (2 * math.pi) < math.pi
        ? angle = 2 * math.pi - (angle % (2 * math.pi))
        : angle = angle;
    if ((angle % (math.pi)).floor() < 2) {
      print(index);
      audioPlayer.resume();
      // audioPlayer.seek(const Duration(seconds: 0));
    }
    canvas.drawCircle(
        Offset(
            (size.width / 2 - ((index * (size.width / 20)) * math.cos(angle))),
            size.height / 2 + ((index * (size.width / 20)) * math.sin(angle))),
        20,
        circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

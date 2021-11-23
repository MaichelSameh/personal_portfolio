import 'package:flutter/material.dart';

import '../models/size.dart' as s;

class BackgroundCircle extends StatelessWidget {
  const BackgroundCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    s.Size _size = s.Size(context);
    return CustomPaint(
      painter: _Circle(_size),
    );
  }
}

class _Circle extends CustomPainter {
  final s.Size _size;
  _Circle(this._size);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.height / 2, size.width / 2),
      _size.width(287),
      Paint()..color = const Color.fromRGBO(20, 41, 99, 0.3),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

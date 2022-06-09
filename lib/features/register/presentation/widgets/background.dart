import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';

class RegisterBackground extends StatelessWidget {
  const RegisterBackground({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _RoundedHeaderPainter(),
      ),
    );
  }
}

class _RoundedHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = kMainPurpleColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5.0;

    final path = Path();

    path.lineTo(0, size.height * 0.40);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.45,
        size.width * 0.42, size.height * 0.40); //del borde hacia el pico
    path.quadraticBezierTo(size.width * 0.80, size.height * 0.27, size.width,
        size.height * 0.30); //del pico hacia el borde(derecho)
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

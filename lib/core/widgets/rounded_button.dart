import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.backColor = kMainPinkColor,
    this.minWidth = 165,
    required this.onPressed,
    this.radius = 30.0,
    required this.text,
    this.textColor = Colors.white,
  }) : super(key: key);

  final Color backColor;
  final double minWidth;
  final VoidCallback onPressed;
  final double radius;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(radius),
        color: backColor,
        elevation: 4.0,
        child: MaterialButton(
          minWidth: minWidth,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w400, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

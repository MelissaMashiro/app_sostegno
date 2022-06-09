import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
    this.width,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: width ?? 80,
        decoration: BoxDecoration(
          color: kDarkBlue,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

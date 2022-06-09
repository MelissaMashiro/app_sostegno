import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';

class PurpleHeader extends StatelessWidget {
  const PurpleHeader({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: kMainPurpleColor,
      height: size.height * 0.22,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            width: 51,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: kMainPurpleColor,
                size: 35,
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

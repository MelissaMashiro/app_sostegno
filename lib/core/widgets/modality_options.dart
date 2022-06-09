import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';

class MonitoryModalityOptions extends StatelessWidget {
  const MonitoryModalityOptions({
    Key? key,
    required this.virtualSelected,
    this.onTapVirtual,
    this.onTapPresential,
  }) : super(key: key);

  final bool virtualSelected;
  final VoidCallback? onTapVirtual;
  final VoidCallback? onTapPresential;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: 60,
        width: 180,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ]),
        child: Row(
          children: [
            InkWell(
              onTap: onTapVirtual,
              child: Container(
                width: 90,
                color: virtualSelected ? kMainPurpleColor : kMidGray,
                child: Center(
                  child: Text(
                    'Virtual',
                    style: TextStyle(
                      color: virtualSelected ? Colors.white : kDarkBlue,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: onTapPresential,
              child: Container(
                color: virtualSelected ? kMidGray : kMainPinkColor,
                width: 90,
                child: Center(
                  child: Text(
                    'Presential',
                    style: TextStyle(
                      color: virtualSelected ? kDarkBlue : Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

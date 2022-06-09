import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/utils/constants.dart';

Future messageDialog(BuildContext context,
    {required String title, required String msg, VoidCallback? action}) {
  return action != null
      ? showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return MyCustomMessageDialog(
              title: title,
              descriptions: msg,
              onPressedOk: action,
            );
          })
      : showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyCustomMessageDialog(
              title: title,
              descriptions: msg,
            );
          });
}

Future errorDialog(BuildContext context,
    {required String title, required String msg, VoidCallback? action}) {
  return action != null
      ? showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return MyCustomMessageDialog(
              title: title,
              descriptions: msg,
              onPressedOk: action,
              iconPath: 'errorIcon.svg',
            );
          })
      : showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyCustomMessageDialog(
              title: title,
              descriptions: msg,
              iconPath: 'errorIcon.svg',
            );
          });
}

class MyCustomMessageDialog extends StatefulWidget {
  final String title, descriptions;
  final String iconPath;
  final VoidCallback? onPressedOk;
  const MyCustomMessageDialog(
      {Key? key,
      required this.title,
      required this.descriptions,
      this.onPressedOk,
      this.iconPath = 'logo_circular.svg'})
      : super(key: key);

  @override
  MyCustomMessageDialogState createState() => MyCustomMessageDialogState();
}

class MyCustomMessageDialogState extends State<MyCustomMessageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(),
    );
  }

  contentBox() {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 45.0 + 20, bottom: 0),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 2,
                color: Colors.black54,
                offset: Offset(0.0, 2.0), //(x,y)
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(widget.title.toUpperCase(),
                    style: const TextStyle(
                      color: kMainPurpleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.descriptions,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: widget.onPressedOk ?? () => Get.back(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: kMainPinkColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text("OK",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(45)),
              child: SvgPicture.asset(
                'assets/images/${widget.iconPath}',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

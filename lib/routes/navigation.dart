import 'package:flutter/material.dart';

Future<dynamic> pushTo(BuildContext context, String routeName,
    {dynamic arguments}) {
  return Navigator.pushNamed(context, routeName, arguments: arguments);
}


Future<dynamic> pushReplacementNamed(BuildContext context, String routeName) {
  return Navigator.pushReplacementNamed(context, routeName);
}

Future<dynamic> pushNamedAndRemoveAll(BuildContext context, String routeName) {
  return Navigator.pushNamedAndRemoveUntil(context, routeName, (_) => false);
}


Future<dynamic> pushWithDataAndRemoveAll(BuildContext context, Widget widget,
    {dynamic arguments}) {
  return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget), (_) => false);
}

Future<dynamic> pushToWithData(BuildContext context, Widget widget,
    {dynamic arguments}) {
  return Navigator.push( context, MaterialPageRoute(builder: (context) => widget));
}
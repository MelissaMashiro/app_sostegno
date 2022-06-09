import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/core/storage/shared_preferences_impl.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    _check(); //revisa si aun no vencen los token
  }

  MySharedPreferences sharedPreferences = MySharedPreferencesImpl();
  _check() async {
    final userEntity = (await sharedPreferences.getUser());
    if (userEntity != null) {
      print("Ha logueado");
      Get.offNamed(RoutesName.My_CALENDAR);
    } else {
      print("deslogueado");
      Get.offNamed(RoutesName.LOGIN_PAGE);
    }
    //Get.offNamed(RoutesName.LOGIN_PAGE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainPurpleColor,
        body: Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: SvgPicture.asset('assets/images/logo_completo.svg'),
          ),
        ));
  }
}

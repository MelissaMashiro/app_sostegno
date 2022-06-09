import 'package:flutter/material.dart';
import 'package:app_sostegno/features/authentication/presentation/widgets/background.dart';
import 'package:app_sostegno/features/authentication/presentation/widgets/login_main_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: const [
            LoginBackground(),
            LoginMainView(),
          ],
        ),
      ),
    );
  }
}

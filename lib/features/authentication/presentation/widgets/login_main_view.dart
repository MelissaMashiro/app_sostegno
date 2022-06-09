import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/widgets/rounded_button.dart';
import 'package:app_sostegno/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:app_sostegno/features/authentication/presentation/widgets/login_form.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class LoginMainView extends StatefulWidget {
  const LoginMainView({Key? key}) : super(key: key);

  @override
  State<LoginMainView> createState() => _LoginMainViewState();
}

class _LoginMainViewState extends State<LoginMainView> {
  bool _switchValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset('assets/images/logo_completo.svg',
                  width: size.width * 0.20),
              const SizedBox(height: 30),
              SvgPicture.asset('assets/images/login_ilustration.svg',
                  width: size.width * 0.70),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: LoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿Eres Monitor?',
                    style: TextStyle(
                        color: kGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  CupertinoSwitch(
                    activeColor: kMainPurpleColor,
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is SuccessfullAuthenticatedState) {
                    Get.toNamed(RoutesName.My_CALENDAR);
                  }
                },
                builder: (context, state) {
                  return state is LoadingState
                      ? const CircularProgressIndicator()
                      : RoundedButton(
                          text: 'Iniciar Sesión',
                          onPressed: () => _validateInputs(context),
                        );
                },
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: () {
                  if (_switchValue) {
                    messageDialog(context,
                        title: "Acción no permitida",
                        msg:
                            "Si eres monitor, tu registro debe realizarse solicitandolo directamente con la oficina encargada de las monitorias, gracias.");
                  } else {
                    Get.toNamed(RoutesName.REGISTER_PAGE);
                  }
                },
                child: const Text.rich(
                  TextSpan(
                    text: '¿Aún no tienes cuenta? ',
                    style: TextStyle(fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Regístrate Aquí',
                        style: TextStyle(
                            color: kMainPinkColor,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validateInputs(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthenticationBloc>().add(
            DoLoginEvent(
              email: _emailController.text,
              password: _passwordController.text,
              userType: _switchValue ? 2 : 1,
            ),
          );
    } else {
      // showErrorDialog(context,
      //     title: 'Campos incompletos',
      //     msg: 'Por favor, rectifique los datos ingresados');
    }
  }
}

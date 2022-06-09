import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sostegno/core/widgets/rounded_button.dart';
import 'package:app_sostegno/features/register/domain/entities/university_entity.dart';
import 'package:app_sostegno/features/register/presentation/bloc/registration_bloc.dart';
import 'package:app_sostegno/features/register/presentation/widgets/registration_form.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class RegisterMainView extends StatefulWidget {
  const RegisterMainView({Key? key}) : super(key: key);

  @override
  State<RegisterMainView> createState() => _RegisterMainViewState();
}

class _RegisterMainViewState extends State<RegisterMainView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<University> universities = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is UniversitiesRetrieved) {
          universities = state.universities;
        }
        if (state is ErrorState) {
          messageDialog(context,
              title: 'ERROR EN EL REGISTRO',
              msg: 'Rectifique los datos ingresados', action: () {
            Get.offNamedUntil(RoutesName.LOGIN_PAGE, (route) => false);
          });
        }
        if (state is SuccessfullRegistration) {
          messageDialog(context,
              title: 'REGISTRO EXITOSO',
              msg: 'Click para volver al login', action: () {
            Get.offNamedUntil(RoutesName.LOGIN_PAGE, (route) => false);
          });
        }
      },
      builder: (context, state) {
        Widget result;
        if (state is ErrorState || state is SuccessfullRegistration) {
          result = const SizedBox();
        } else if (state is LoadingState) {
          result = Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: Image.asset(
                'assets/gifs/studying_lila.gif',
                height: 300,
                width: 300,
              ),
            ),
          );
        } else {
          result = Align(
            alignment: Alignment.center,
            child: ListView(
              children: [
                SizedBox(height: size.height * 0.10),
                const Center(
                  child: Text(
                    'REGISTRO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 30,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
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
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: RegistrationForm(
                        uniList: universities,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Center(
                          child: Image.asset('assets/gifs/studying.gif'),
                        );
                      } else if (state is ErrorState) {
                        return const SizedBox();
                      } else {
                        return RoundedButton(
                          text: 'Registrarse',
                          onPressed: () => _validateInputs(context),
                        );
                      }
                    },
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text.rich(
                      TextSpan(
                        text: '¿Ya tienes cuenta? ',
                        style: TextStyle(fontSize: 15),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Inicia Sesión',
                            style: TextStyle(
                                color: kMainPinkColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        }
        return result;
      },
    );
  }

  void _validateInputs(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<RegistrationBloc>().add(DoRegisterEvent());
      //Get.toNamed(RoutesName.REGISTSTEP2_PAGE);
    } else {
      // showErrorDialog(context,
      //     title: 'Campos incompletos',
      //     msg: 'Por favor, rectifique los datos ingresados');
    }
  }
}

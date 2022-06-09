import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sostegno/features/register/presentation/bloc/registration_bloc.dart';
import 'package:app_sostegno/features/register/presentation/widgets/background.dart';
import 'package:app_sostegno/features/register/presentation/widgets/register_main_view.dart';
import 'package:app_sostegno/injection_container.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegistrationBloc>()..add(InitialPageEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Stack(
            children: const [
              RegisterBackground(),
              RegisterMainView(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/utils/validation_methods.dart';
import 'package:app_sostegno/features/authentication/presentation/widgets/login_text_field.dart';
import 'package:app_sostegno/features/authentication/authentication.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);
  final TextEditingController emailController;

  final TextEditingController passwordController;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LoginTextField(
            backgroundColor: const Color(0xFF282F3F),
            controller: widget.emailController,
            hintText: 'Email',
            icon: const Icon(
              Icons.email,
              color: kMainPinkColor,
            ),
            showError: state is ErrorState,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          LoginTextField(
            backgroundColor: const Color(0xFF282F3F),
            controller: widget.passwordController,
            hintText: 'Contraseña',
            obscureText: _isHidden,
            showError: state is ErrorState,
            icon: IconButton(
              color: kMainPinkColor,
              icon: _isHidden
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: _toggleVisibility,
            ),
          ),
        ],
      );
    });
  }
}

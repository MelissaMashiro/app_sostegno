import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key? key,
    this.backgroundColor,
    this.controller,
    @required this.hintText,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.onSaved,
    required this.showError,
    this.validator,
  }) : super(key: key);

  final Color? backgroundColor;

  final TextEditingController? controller;
  final String? hintText;
  final Widget? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String?)? onSaved;
  final bool showError;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.red,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kMainPurpleColor),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          prefixIcon: icon,
          errorText: showError ? 'Usuario o contraseña incorrecto' : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color.fromARGB(23, 0, 0, 0))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xffB00020), width: 2)),
          errorStyle: const TextStyle(
              color: Color(0xffB00020),
              fontSize: 12,
              fontWeight: FontWeight.normal),
        ),
        validator: validator,
        cursorColor: Colors.black45,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onSaved: onSaved,
      ),
    );
  }
}

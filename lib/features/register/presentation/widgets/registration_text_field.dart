import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';

class RegistrationTextField extends StatelessWidget {
  const RegistrationTextField({
    Key? key,
    this.backgroundColor,
    this.controller,
    @required this.hintText,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onSaved;

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

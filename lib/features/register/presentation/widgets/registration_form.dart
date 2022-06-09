import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sostegno/core/utils/validation_methods.dart';
import 'package:app_sostegno/features/register/domain/entities/university_entity.dart';
import 'package:app_sostegno/features/register/presentation/widgets/registration_text_field.dart';
import 'package:app_sostegno/features/register/presentation/bloc/registration_bloc.dart';
import 'package:app_sostegno/features/register/presentation/widgets/universities_dropdown.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key, required this.uniList}) : super(key: key);
  final List<University> uniList;
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  Map<String, dynamic> _newUserData = {};
  //List<University> universities = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentcodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isHidden = true;
  @override
  void initState() {
    _newUserData = {};
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    _newUserData = context.watch<RegistrationBloc>().newUserData;
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is UniversitiesRetrieved) {
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UniversitiesDropdown(
              actualValue: _newUserData['university'],
              hintText: 'Seleccione su Universidad',
              itemList: widget.uniList,
              onChanged: (opt) {},
              onSaved: (val) {
                _newUserData['university'] = val.id;
              },
            ),
            RegistrationTextField(
              backgroundColor: const Color(0xFF282F3F),
              controller: _nameController,
              hintText: 'Nombres',
              icon: const Icon(
                Icons.people,
                color: kMainPinkColor,
              ),
              keyboardType: TextInputType.name,
              validator: (val) => validateString(val, 5),
              onSaved: (val) {
                _newUserData['first_name'] = val;
              },
            ),
            RegistrationTextField(
              backgroundColor: const Color(0xFF282F3F),
              controller: _lastnameController,
              hintText: 'Apellidos',
              icon: const Icon(
                Icons.people_alt,
                color: kMainPinkColor,
              ),
              keyboardType: TextInputType.name,
              validator: validateApellido,
              onSaved: (val) {
                _newUserData['last_name'] = val;
              },
            ),
            RegistrationTextField(
              backgroundColor: const Color(0xFF282F3F),
              controller: _emailController,
              hintText: 'Email',
              icon: const Icon(
                Icons.email,
                color: kMainPinkColor,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
              onSaved: (val) {
                _newUserData['email'] = val;
              },
            ),
            RegistrationTextField(
              backgroundColor: const Color(0xFF282F3F),
              controller: _studentcodeController,
              hintText: 'Codigo Estudiante',
              icon: const Icon(
                Icons.code,
                color: kMainPinkColor,
              ),
              keyboardType: TextInputType.number,
              validator: validateCodigo,
              onSaved: (val) {
                _newUserData['studentCode'] = val;
              },
            ),
            RegistrationTextField(
              backgroundColor: const Color(0xFF282F3F),
              controller: _passwordController,
              hintText: 'Contraseña',
              obscureText: _isHidden,
              icon: IconButton(
                color: kMainPinkColor,
                icon: _isHidden
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: _toggleVisibility,
              ),
              onSaved: (val) {
                _newUserData['password'] = val;
              },
              validator: validatePassword,
            ),
          ],
        );
      },
    );
  }
}

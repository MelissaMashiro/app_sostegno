import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/purple_header.dart';
import 'package:app_sostegno/core/widgets/rounded_button.dart';
import 'package:app_sostegno/features/monitory_request_creation/presentation/bloc/monitory_request_creation_bloc.dart';
import 'package:app_sostegno/features/monitory_request_creation/presentation/widgets/make_monitory_request_form.dart';
import 'package:app_sostegno/injection_container.dart';

class MakeMonitoryRequestPage extends StatefulWidget {
  const MakeMonitoryRequestPage({Key? key}) : super(key: key);

  @override
  State<MakeMonitoryRequestPage> createState() =>
      _MakeMonitoryRequestPageState();
}

class _MakeMonitoryRequestPageState extends State<MakeMonitoryRequestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<MonitoryRequestCreationBloc>()..add(InitialRequestCreationEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kGrayBackgroundColor,
          body: DefaultTextStyle(
            style: const TextStyle(
              color: kDarkBlue,
              letterSpacing: 0.2,
              fontSize: 17,
            ),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PurpleHeader(
                    title: 'Crear Nueva Solicitud',
                    icon: Icons.arrow_back,
                    onPressed: () => Get.back(),
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: const MakeMonitoryRequestForm(),
                  ),
                  Align(
                    child: Builder(builder: (context) {
                      return RoundedButton(
                        text: 'Solicitar Monitoria',
                        onPressed: () => _validateInputs(context),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateInputs(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<MonitoryRequestCreationBloc>().add(DoCreateRequest());
    } else {}
  }
}

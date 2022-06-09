import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/purple_header.dart';
import 'package:app_sostegno/core/widgets/rounded_button.dart';
import 'package:app_sostegno/features/monitory_creation/presentation/bloc/monitory_creation_bloc.dart';
import 'package:app_sostegno/features/monitory_creation/presentation/widgets/create_monitory_form.dart';
import 'package:app_sostegno/features/monitory_requests/domain/entities/request_entity.dart';
import 'package:app_sostegno/injection_container.dart';

class CreateMonitoryPage extends StatefulWidget {
  const CreateMonitoryPage({Key? key}) : super(key: key);

  @override
  CreateMonitoryPageState createState() => CreateMonitoryPageState();
}

class CreateMonitoryPageState extends State<CreateMonitoryPage> {
  final bool hasPreData = Get.arguments['hasPreData'];
  Request? _preData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (hasPreData) {
      _preData = Get.arguments['requestData'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<MonitoryCreationBloc>()..add(InitialMonitoryCreationEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kGrayBackgroundColor,
          body: DefaultTextStyle(
            style: const TextStyle(
              color: kDarkBlue,
              letterSpacing: 0.2,
              fontSize: 17,
            ),
            child: Column(
              children: [
                PurpleHeader(
                  title: 'Crear Monitoría',
                  icon: Icons.arrow_back,
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: ListView(
                      children: [
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: CreateMonitoryForm(preData: _preData),
                        ),
                        Align(
                          child: Builder(builder: (context) {
                            return RoundedButton(
                              onPressed: () => _validateInputs(context),
                              text: 'Crear Monitoría',
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateInputs(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<MonitoryCreationBloc>()
          .add(DoCreateMonitory()); //Get.toNamed(RoutesName.REGISTSTEP2_PAGE);
    } else {
      // showErrorDialog(context,
      //     title: 'Campos incompletos',
      //     msg: 'Por favor, rectifique los datos ingresados');
    }
  }
}

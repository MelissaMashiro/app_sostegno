import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/purple_header.dart';
import 'package:app_sostegno/core/widgets/rounded_button.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/enroll_to_monitory_domain.dart';
import 'package:app_sostegno/features/enroll_to_monitory/presentation/bloc/enroll_to_monitory_bloc.dart';
import 'package:app_sostegno/features/enroll_to_monitory/presentation/widgets/monitores_dropwdown.dart';
import 'package:app_sostegno/features/monitories/presentation/monitor_monitories/widgets/materias_dropdown.dart';
import 'package:app_sostegno/routes/routes_name.dart';

import '../../../../injection_container.dart';

class EnrollStep1Page extends StatefulWidget {
  const EnrollStep1Page({Key? key}) : super(key: key);

  @override
  State<EnrollStep1Page> createState() => _EnrollStep1PageState();
}

class _EnrollStep1PageState extends State<EnrollStep1Page> {
  CustomMateria? _actualMateria;
  Monitor? _actualMonitor;
  List<CustomMateria> _allMaterias = [];
  List<Monitor> _allMonitores = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => sl<EnrollToMonitoryBloc>()..add(InitialPageEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kGrayBackgroundColor,
          body: Column(
            children: [
              PurpleHeader(
                title: 'Incribirme a Monitoria',
                icon: Icons.arrow_back,
                onPressed: () {
                  Get.back();
                },
              ),
              BlocListener<EnrollToMonitoryBloc, EnrollToMonitoryState>(
                listener: (context, state) {
                  if (state is ErrorState) {
                    errorDialog(
                      context,
                      title: 'Error Inesperado',
                      msg: 'Ha ocurrido un error, por favor intente de nuevo',
                      action: () {
                        Get.offNamedUntil(
                          RoutesName.My_CALENDAR,
                          (route) => false,
                        );
                      },
                    );
                  } else if (state is MateriasRetrieved) {
                    _allMaterias = state.materias;
                  } else if (state is MonitoresRetrieved) {
                    _actualMonitor = null;
                    _allMonitores = state.monitores;
                  } else if (state is MonitoriesRetrieved) {
                    Get.toNamed(
                      RoutesName.ENROLL_MONITORY_STEP2,
                      arguments: {
                        'enrollToMonitoryBloc':
                            context.read<EnrollToMonitoryBloc>(),
                      },
                    );
                  }
                },
                child: Expanded(
                  child: Center(
                    child: Container(
                      width: mq.width * 0.70,
                      height: mq.height * 0.40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              spreadRadius: 2)
                        ],
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BlocBuilder<EnrollToMonitoryBloc,
                                EnrollToMonitoryState>(
                              builder: (context, state) {
                                return MateriasDropdown(
                                  actualValue: _actualMateria,
                                  borderColor: kMainPurpleColor,
                                  hintText: 'Materia',
                                  itemList: _allMaterias,
                                  onChanged: (val) {
                                    _actualMateria = val;
                                    context.read<EnrollToMonitoryBloc>().add(
                                          DoMateriaSelectedEvent(
                                            materia: val,
                                          ),
                                        );
                                  },
                                );
                              },
                            ),
                            BlocBuilder<EnrollToMonitoryBloc,
                                EnrollToMonitoryState>(
                              builder: (context, state) {
                                if (state is LoadingState) {
                                  return const CircularProgressIndicator();
                                } else if (state is MonitoresRetrieved) {
                                  return MonitoresDropdown(
                                    actualValue: _actualMonitor,
                                    borderColor: kMainPurpleColor,
                                    hintText: 'Monitor',
                                    itemList: _allMonitores,
                                    requireed: false,
                                    onChanged: (val) {
                                      _actualMonitor = val;
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            Builder(builder: (context) {
                              return RoundedButton(
                                onPressed: () => _validateInputs(context),
                                text: 'Buscar',
                                backColor: kDarkBlue,
                              );
                            })
                          ],
                        ),
                      ),
                    ),
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

      context.read<EnrollToMonitoryBloc>().add(DoSearchEvent(
            materia: _actualMateria!,
            monitor: _actualMonitor,
          ));
    } else {
      // showErrorDialog(context,
      //     title: 'Campos incompletos',
      //     msg: 'Por favor, rectifique los datos ingresados');
    }
  }
}

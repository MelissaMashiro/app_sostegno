import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/date_picker.dart';
import 'package:app_sostegno/core/widgets/modality_options.dart';
import 'package:app_sostegno/core/widgets/time_picker.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitory_creation/presentation/bloc/monitory_creation_bloc.dart';
import 'package:app_sostegno/features/monitory_creation/presentation/widgets/porcentaje_materia_dropdown.dart';
import 'package:app_sostegno/features/monitory_requests/domain/entities/request_entity.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class CreateMonitoryForm extends StatefulWidget {
  const CreateMonitoryForm({Key? key, this.preData}) : super(key: key);
  final Request? preData;
  @override
  _CreateMonitoryFormState createState() => _CreateMonitoryFormState();
}

class _CreateMonitoryFormState extends State<CreateMonitoryForm> {
  late Request preData;
  Map<String, dynamic> _newMonitoryData = {};
  List<MonitorMonitoria> _materias = [];

  MonitorMonitoria? _asignatureSelected;
  bool _virtualSelected = true;
  late Size _mq;

  late String _setinitialTime;
  late String _setFinalTime;

  late String _hour, _minute, _time;

  TimeOfDay selectedInitialTime = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedFinalTime = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _initTimeController = TextEditingController();
  final TextEditingController _finalTimeController = TextEditingController();

  @override
  void initState() {
    if (widget.preData != null) {
      preData = widget.preData!;
      _setinitialTime = preData.fecha.toIso8601String().split('T')[1];
      selectedInitialTime = TimeOfDay(
          hour: int.parse(_setinitialTime.split(':')[0]),
          minute: int.parse(_setinitialTime.split(':')[1]));
      _initTimeController.text = formatDate(
        DateTime(
          2019,
          08,
          1,
          int.parse(_setinitialTime.split(':')[0]),
          int.parse(_setinitialTime.split(':')[1]),
        ),
        [hh, ':', nn, " ", am],
      ).toString();
      _setFinalTime = preData.fin;
      selectedFinalTime = TimeOfDay(
          hour: int.parse(_setFinalTime.split(':')[0]),
          minute: int.parse(_setFinalTime.split(':')[1]));

      _finalTimeController.text = formatDate(
        DateTime(
          2019,
          08,
          1,
          int.parse(_setFinalTime.split(':')[0]),
          int.parse(_setFinalTime.split(':')[1]),
        ),
        [hh, ':', nn, " ", am],
      ).toString();
    } else {
      _initTimeController.text = formatDate(
        DateTime(
            2019, 08, 1, selectedInitialTime.hour, selectedInitialTime.minute),
        [hh, ':', nn, " ", am],
      ).toString();
      _finalTimeController.text = formatDate(
        DateTime(2019, 08, 1, selectedFinalTime.hour, selectedFinalTime.minute),
        [hh, ':', nn, " ", am],
      ).toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _newMonitoryData = context.watch<MonitoryCreationBloc>().newMonitoryData;

    _mq = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<MonitoryCreationBloc, MonitoryCreationState>(
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
            }
            if (state is MateriasRetrieved) {
              _materias = state.materias;
            }
            if (state is SuccessMonitoryCreation) {
              messageDialog(context,
                  title: 'Creación Exitosa',
                  msg: 'Click para volver al Home', action: () {
                Get.offNamedUntil(RoutesName.My_CALENDAR, (route) => false);
              });
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorState) {
              return const SizedBox();
            } else {
              return Column(
                children: [
                  widget.preData == null
                      ? PocentajeDropdown(
                          actualValue: _asignatureSelected,
                          borderColor: kMainPurpleColor,
                          hintText: 'Seleccione una materia',
                          itemList: _materias,
                          onChanged: (val) {
                            setState(() {
                              _asignatureSelected = val;
                            });
                            _newMonitoryData['porcentaje'] = val;
                          },
                        )
                      : Text(preData.materia.nombre),
                  const SizedBox(
                    height: 20.0,
                  ),
                  widget.preData == null
                      ? Column(
                          children: [
                            const Text('Escoge el día'),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 78.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: kMainPurpleColor, width: 1.3),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                              ),
                              child: Align(
                                child: MyDateBox(
                                  hintText: 'Seleccione dia',
                                  keyName: 'day', map: _newMonitoryData,
                                  //validationAdult: widget.familiarType == ADULTO ? true : false),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          preData.fecha.toIso8601String().split('T')[0],
                        ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text('Escoge la hora de inicio y de fin'),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimePickerBox(
                        onTap: () {
                          _selectTime(context, true);
                        },
                        timeController: _initTimeController,
                        mq: _mq,
                        onSaved: (String? val) {
                          _newMonitoryData['horaInicio'] = _setinitialTime;
                        },
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      TimePickerBox(
                        onTap: () {
                          _selectTime(
                            context,
                            false,
                          );
                        },
                        timeController: _finalTimeController,
                        mq: _mq,
                        onSaved: (String? val) {
                          _newMonitoryData['horaFin'] = _setFinalTime;
                        },
                        validator: (val) => _timeValidation(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text('Selecciona la modalidad'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MonitoryModalityOptions(
                    virtualSelected: _virtualSelected,
                    onTapVirtual: () {
                      setState(() {
                        _virtualSelected = true;
                      });
                    },
                    onTapPresential: () {
                      setState(() {
                        _virtualSelected = false;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(_virtualSelected
                      ? 'Enlace de encuentro:'
                      : 'Salon de Encuentro'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kMainPurpleColor, width: 1.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                      child: _virtualSelected
                          ? TextFormField(
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.red,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'https://google.meets.com',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                prefixIcon: Icon(Icons.link),
                              ),
                              validator: (val) =>
                                  val!.isEmpty ? 'Campo obligatorio' : null,
                              cursorColor: Colors.black45,
                              keyboardType: TextInputType.multiline,
                              onSaved: (val) {
                                print('ENTRE A ONSAVED');
                                _newMonitoryData['detalles'] = val;
                                _newMonitoryData['modality'] =
                                    _virtualSelected ? 0 : 1;
                                if (widget.preData != null) {
                                  _newMonitoryData['materia'] =
                                      preData.materia.nombre;
                                  _newMonitoryData['day'] = preData.fecha
                                      .toIso8601String()
                                      .split('T')[0];
                                  _newMonitoryData['idRequest'] = preData.id;
                                }
                              },
                            )
                          : TextFormField(
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.red,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Torre E Salon 201',
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                                prefixIcon: Icon(Icons.class_outlined),
                              ),
                              validator: (val) =>
                                  val!.isEmpty ? 'Campo obligatorio' : null,
                              cursorColor: Colors.black45,
                              keyboardType: TextInputType.multiline,
                              onSaved: (val) {
                                print('ENTRE A ONSAVED');
                                _newMonitoryData['detalles'] = val;
                                _newMonitoryData['modality'] =
                                    _virtualSelected ? 0 : 1;
                                if (widget.preData != null) {
                                  _newMonitoryData['materia'] =
                                      preData.materia.nombre;
                                  _newMonitoryData['day'] = preData.fecha
                                      .toIso8601String()
                                      .split('T')[0];
                                  _newMonitoryData['idRequest'] = preData.id;
                                }
                              },
                            ),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }

  Future<void> _selectTime(BuildContext context, bool initial) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedInitialTime,
    );
    if (picked != null) {
      if (initial == true) {
        setState(() {
          selectedInitialTime = picked;
          _hour = selectedInitialTime.hour.toString();
          _minute = selectedInitialTime.minute.toString();
          _time = '$_hour:$_minute:00';
          _setinitialTime = _time;
          _initTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedInitialTime.hour,
                selectedInitialTime.minute),
            [hh, ':', nn, " ", am],
          ).toString();
        });
      } else {
        setState(() {
          selectedFinalTime = picked;
          _hour = selectedFinalTime.hour.toString();
          _minute = selectedFinalTime.minute.toString();
          _time = '$_hour:$_minute:00';
          _setFinalTime = _time;
          _finalTimeController.text = formatDate(
            DateTime(
                2019, 08, 1, selectedFinalTime.hour, selectedFinalTime.minute),
            [hh, ':', nn, " ", am],
          ).toString();
        });
      }
    }
  }

  String? _timeValidation() {
    var hourComparation =
        selectedFinalTime.hour.compareTo(selectedInitialTime.hour);
    if (hourComparation < 0) {
      return 'seleccione horarios validos';
    } else if (hourComparation == 0) {
      var minutesComparation =
          selectedFinalTime.minute.compareTo(selectedInitialTime.minute);
      if (minutesComparation <= 0) {
        return 'seleccione horarios validos';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sostegno/core/widgets/date_picker.dart';
import 'package:app_sostegno/core/widgets/time_picker.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/materia.dart';
import 'package:app_sostegno/features/monitories/presentation/monitor_monitories/widgets/materias_dropdown.dart';
import 'package:app_sostegno/features/monitory_request_creation/presentation/bloc/monitory_request_creation_bloc.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class MakeMonitoryRequestForm extends StatefulWidget {
  const MakeMonitoryRequestForm({Key? key}) : super(key: key);

  @override
  MakeMonitoryRequestFormState createState() =>
      MakeMonitoryRequestFormState();
}

List<CustomMateria> _materias = [];

class MakeMonitoryRequestFormState extends State<MakeMonitoryRequestForm> {
  Map<String, dynamic> _newRequestData = {};

  CustomMateria? _asignatureSelected;
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
    _initTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    _finalTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _newRequestData =
        context.watch<MonitoryRequestCreationBloc>().newRquestData;

    _mq = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<MonitoryRequestCreationBloc,
            MonitoryRequestCreationState>(
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
            if (state is SuccessRequestCreation) {
              messageDialog(
                context,
                title: 'Solicitud Exitosa',
                msg:
                    'Solo queda esperar que los monitores reciban tu solicitud, ten paciencia. Gracias!',
                action: () {
                  Get.offNamedUntil(
                    RoutesName.My_CALENDAR,
                    (route) => false,
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                MateriasDropdown(
                  actualValue: _asignatureSelected,
                  borderColor: kMainPurpleColor,
                  hintText: 'Seleccione una materia',
                  itemList: _materias,
                  onChanged: (val) {
                    setState(() {
                      _asignatureSelected = val;
                    });
                    _newRequestData['materia'] = _asignatureSelected;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Escoge el día'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 75,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kMainPurpleColor, width: 1.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                  child: Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: MyDateBox(
                        hintText: 'Seleccione dia',
                        keyName: 'day',
                        map: _newRequestData,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Escoge la hora de inicio y de fin'),
                const SizedBox(
                  height: 5,
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
                        _newRequestData['horaInicio'] = _setinitialTime;
                      },
                    ),
                    const SizedBox(width: 20),
                    TimePickerBox(
                      onTap: () {
                        _selectTime(context, false);
                      },
                      timeController: _finalTimeController,
                      mq: _mq,
                      onSaved: (String? val) {
                        _newRequestData['horaFin'] = _setFinalTime;
                      },
                      validator: (val) => _timeValidation(),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
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

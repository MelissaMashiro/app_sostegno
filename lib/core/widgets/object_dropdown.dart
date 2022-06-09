import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';

class ObjectDropdown extends StatefulWidget {
  const ObjectDropdown({
    Key? key,
    required this.actualValue,
    required this.hintText,
    required this.itemList,
    this.onSaved,
    required this.onChanged,
    this.width,
    this.borderColor,
    this.requireed = true,
  }) : super(key: key);

  final dynamic actualValue;
  final Color? borderColor;
  final List<MonitorMonitoria> itemList;
  final String hintText;
  final Function(dynamic)? onSaved;
  final Function(dynamic)? onChanged;
  final double? width;
  final bool? requireed;

  @override
  ObjectDropdownState createState() => ObjectDropdownState();
}

class ObjectDropdownState extends State<ObjectDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      width: widget.width ?? 225,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: widget.borderColor ?? kMainPinkColor,
          width: 1.3,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      child: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: DropdownButtonFormField(
            isExpanded: true,
            validator: widget.requireed == true
                ? ((value) => value == null ? 'Campo requerido' : null)
                : null,
            decoration: InputDecoration.collapsed(hintText: widget.hintText),
            hint: Text(widget.hintText, textAlign: TextAlign.center),
            value: widget.actualValue,
            items: getOpcionesDropdown(widget.itemList),
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> getOpcionesDropdown(
      List<MonitorMonitoria> myList) {
    List<DropdownMenuItem<int>> list = [];
    for (var item in myList) {
      list.add(DropdownMenuItem(
        value: item.materia.id,
        child: Text(item.materia.nombre),
      ));
    }
    return list;
  }
}

import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/enroll_to_monitory_domain.dart';

class MonitoresDropdown extends StatefulWidget {
  const MonitoresDropdown({
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
  final List<Monitor> itemList;
  final String hintText;
  final Function(dynamic)? onSaved;
  final Function(dynamic)? onChanged;
  final double? width;
  final bool? requireed;

  @override
  MonitoresDropdownState createState() => MonitoresDropdownState();
}

class MonitoresDropdownState extends State<MonitoresDropdown> {
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
          Radius.circular(32),
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

  List<DropdownMenuItem<Monitor>> getOpcionesDropdown(List<Monitor> myList) {
    List<DropdownMenuItem<Monitor>> list = [];
    for (var item in myList) {
      list.add(DropdownMenuItem(
        value: item,
        child: Text(
            '${item.monitor!.monitorUser.firstName} ${item.monitor!.monitorUser.lastName}'),
      ));
    }
    return list;
  }
}

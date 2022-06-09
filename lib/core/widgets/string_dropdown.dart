import 'package:flutter/material.dart';

import '../utils/constants.dart';

class StringDropdown extends StatefulWidget {
  const StringDropdown({
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
  final List itemList;
  final String hintText;
  final Function(String?)? onSaved;
  final Function(String?) onChanged;
  final double? width;
  final bool? requireed;

  @override
  StringDropdownState createState() => StringDropdownState();
}

class StringDropdownState extends State<StringDropdown> {
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
          child: DropdownButtonFormField<String>(
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

  List<DropdownMenuItem<String>> getOpcionesDropdown(List myList) {
    List<DropdownMenuItem<String>> list = [];
    for (var item in myList) {
      list.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    }
    return list;
  }
}

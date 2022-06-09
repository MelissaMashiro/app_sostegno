import 'package:flutter/material.dart';

class TimePickerBox extends StatelessWidget {
  const TimePickerBox({
    Key? key,
    required this.onTap,
    this.onSaved,
    required this.timeController,
    required this.mq,
    this.validator,
  }) : super(key: key);

  final Size mq;
  final VoidCallback onTap;
  final Function(String?)? onSaved;
  final TextEditingController timeController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: mq.width / 3.7,
        height: mq.height / 10,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: TextFormField(
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          onSaved: onSaved,
          enabled: false,
          keyboardType: TextInputType.text,
          controller: timeController,
          decoration: const InputDecoration(
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              // labelText: 'Time',
              contentPadding: EdgeInsets.all(5)),
          validator: validator,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyDateBox extends StatefulWidget {
  const MyDateBox(
      {Key? key,
      required this.map,
      required this.hintText,
      required this.keyName,
      this.validationAdult = true})
      : super(key: key);
  final Map<String, dynamic> map;
  final String keyName;
  final String hintText;
  final bool validationAdult;
  @override
  MyDateBoxState createState() => MyDateBoxState();
}

class MyDateBoxState extends State<MyDateBox> {
  //birthday
  DateTime selectedDate = DateTime.now();
  final TextEditingController _labelController = TextEditingController();

  @override
  void initState() {
    _labelController.text = widget.hintText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
              onTap: () => _selectDate(context),
              onSaved: (val) => widget.map[widget.keyName] =
                  "${selectedDate.toLocal()}".split(' ')[0],
              readOnly: true,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
              controller: _labelController,
              validator: (val) {
                return (selectedDate.toLocal().difference(DateTime.now()) <
                        const Duration(days: 1))
                    ? 'Seleccione dia'
                    : null;
              }),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        // locale:Locale('es','CO') ,
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _labelController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }
}

import 'package:diagon/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class DateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        decoration: kTextFieldDecoration.copyWith(
          hintText: 'Enter Date of Birth',
          prefixIcon: Icon(
            FontAwesomeIcons.calendarAlt,
            size: 20.0,
          ),
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
        },
      ),
    ]);
  }
}

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:dsr_clone/shared/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../style/app_input_decoration.dart';

class DatePickerControl extends StatefulWidget {
  final TextEditingController? controller;
  final Function(DateTime?)? onChanged;
  final bool smartForm;

  const DatePickerControl({
    super.key,
    this.controller,
    this.smartForm = false,
    this.onChanged,
  });

  @override
  State<DatePickerControl> createState() => _DatePickerControlState();
}

class _DatePickerControlState extends State<DatePickerControl> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime initialDate = DateTime(today.year, today.month, today.day);

    return DateTimeField(
      controller: widget.controller,
      initialValue: initialDate, // Set initial value to today's date
      decoration: AppInputDecoration.inputDecorationFormWithBorder(
        labelText: 'Date',
        hintText: 'Select Date',
      ),
      style: AppTextStyle.textFieldTextStyle(),
      resetIcon: null,
      format: DateFormat('yyyy-MM-dd'), // Format to show only date
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          locale: const Locale('en', 'IN'),
          context: context,
          firstDate: initialDate,
          initialDate: initialDate,
          lastDate: initialDate,
        );
      },
      onChanged: widget.onChanged,
    );
  }
}
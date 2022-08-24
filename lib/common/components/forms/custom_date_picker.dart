import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final CustomFormInput input;
  final DateTime firstDate;
  final DateTime lastDate;
  final TextStyle inputStyle;

  const CustomDatePicker({
    Key? key,
    required this.input,
    required this.firstDate,
    required this.lastDate,
    TextStyle? inputStyle,
  })  : inputStyle = inputStyle ??
            const TextStyle(fontSize: 16.0, height: 1, color: Colors.black),
        super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    if (picked != null) {
      setState(() {
        widget.input.controller.text = DateFormat('yyyy-MM-dd').format(picked);
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.input.controller,
        readOnly: true,
        style: widget.inputStyle,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.21)),
        onTap: () {
          _selectDate(context);
        });
  }
}

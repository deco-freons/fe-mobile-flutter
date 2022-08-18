import 'package:flutter/cupertino.dart';

class CustomFormInput {
  String label;
  String type;
  DateTime firstDate;
  DateTime lastDate;
  String pattern;
  String errorMessage;
  TextEditingController controller = TextEditingController();

  CustomFormInput({
    required this.label,
    required this.type,
    DateTime? firstDate,
    DateTime? lastDate,
    this.pattern = "",
    this.errorMessage = "",
  })  : firstDate = firstDate ?? DateTime(1900),
        lastDate = lastDate ?? DateTime(2101);
}

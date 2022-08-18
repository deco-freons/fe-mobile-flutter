import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/common/config/type.dart';

class CustomFormInput {
  String label;
  Type type;
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

import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class CustomFormInput {
  String label;
  TextFieldType type;
  DateTime firstDate;
  DateTime lastDate;
  String pattern;
  String errorMessage;
  bool confirmField;
  TextEditingController controller = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  CustomFormInput({
    required this.label,
    required this.type,
    DateTime? firstDate,
    DateTime? lastDate,
    this.pattern = "",
    this.errorMessage = "",
    this.confirmField = false,
  })  : firstDate = firstDate ?? DateTime(1900),
        lastDate = lastDate ?? DateTime(2101);
}

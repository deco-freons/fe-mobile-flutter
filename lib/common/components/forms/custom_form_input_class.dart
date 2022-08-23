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
  String initialValue;
  TextEditingController controller = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool disable;

  CustomFormInput({
    required this.label,
    required this.type,
    DateTime? firstDate,
    DateTime? lastDate,
    this.pattern = "",
    this.errorMessage = "",
    this.confirmField = false,
    String? initialValue,
    this.disable = false,
  })  : firstDate = firstDate ?? DateTime(1900),
        lastDate = lastDate ?? DateTime(2101),
        initialValue = initialValue ?? "",
        controller = TextEditingController(text: initialValue);

  void initState() {
    controller.text = initialValue;
  }
}

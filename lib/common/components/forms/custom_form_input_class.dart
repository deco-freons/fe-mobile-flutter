import 'package:flutter/cupertino.dart';

class CustomFormInput {
  String label;
  String type;
  String errorMessage;
  TextEditingController controller = TextEditingController();

  CustomFormInput({
    required this.label,
    required this.type,
    this.errorMessage = "",
  });
}

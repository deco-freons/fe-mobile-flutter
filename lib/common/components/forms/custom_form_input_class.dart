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
  TextEditingController? secondController;
  TextEditingController confirmController = TextEditingController();
  double lat;
  double lng;
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
    this.lat = 0,
    this.lng = 0,
    this.disable = false,
  })  : firstDate = firstDate ?? DateTime(1900),
        lastDate = lastDate ?? DateTime(2101),
        initialValue = initialValue ?? "",
        controller = TextEditingController(text: initialValue),
        secondController =
            (type == TextFieldType.eventTime) ? TextEditingController() : null;

  void initState() {
    controller.text = initialValue;
  }

  void setLatLng(double lat, double lng) {
    this.lat = lat;
    this.lng = lng;
  }
}

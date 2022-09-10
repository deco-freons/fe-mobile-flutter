import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<dynamic> options;
  final List<dynamic> texts;
  final ValueSetter<dynamic> callback;
  final dynamic initialValue;

  const CustomDropdownButton(
      {Key? key,
      required this.options,
      required this.texts,
      required this.callback,
      required this.initialValue})
      : super(key: key);

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  dynamic selected;
  dynamic value;

  @override
  initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: widget.options
          .asMap()
          .map((i, option) => MapEntry(
              i, DropdownMenuItem(value: option, child: Text(widget.texts[i]))))
          .values
          .toList(),
      value: value,
      onChanged: (dynamic selected) {
        setState(() {
          value = selected!;
        });
        widget.callback(value);
      },
      iconSize: 40.0,
      iconEnabledColor: neutral.shade900,
      underline: Container(
        color: neutral.shade100,
      ),
    );
  }
}

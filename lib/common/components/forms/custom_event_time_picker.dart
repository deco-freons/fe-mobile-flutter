import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/time_util.dart';

class CustomEventTimePicker extends StatelessWidget {
  final CustomFormInput input;
  final TextStyle labelStyle;
  final TextStyle inputStyle;
  const CustomEventTimePicker(
      {Key? key,
      required this.input,
      required this.labelStyle,
      required this.inputStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _selectTime(TextEditingController controller) async {
      final TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.input,
          builder: (context, childWidget) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: primary,
                      onSurface: primary,
                    ),
                  ),
                  child: childWidget!,
                ));
          });
      if (newTime != null) {
        String hour =
            newTime.hour < 10 ? "0${newTime.hour}" : "${newTime.hour}";
        String minute =
            newTime.minute < 10 ? "0${newTime.minute}" : "${newTime.minute}";
        controller.text = "$hour:$minute";
      }
    }

    Widget buildTimeField(String label, TextEditingController controller) {
      return Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: labelStyle,
            ),
            TextFormField(
              controller: controller,
              style: inputStyle,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1.0, color: Theme.of(context).colorScheme.error),
                ),
                helperText: "",
                errorMaxLines: 2,
                filled: true,
                fillColor: primary.shade300,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              readOnly: true,
              validator: (value) {
                if (input.secondController != null) {
                  if (input.controller.text != "" &&
                      input.secondController!.text != "") {
                    if (TimeUtil.greaterThanEqual(
                        input.controller.text, input.secondController!.text)) {
                      return "End time has to be greater";
                    }
                  }
                }

                if (value == "") {
                  return "Required field";
                } else {
                  return null;
                }
              },
              onTap: () {
                _selectTime(controller);
              },
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        buildTimeField("Start time", input.controller),
        const SizedBox(
          width: 25.0,
        ),
        buildTimeField("End time", input.secondController!),
      ],
    );
  }
}

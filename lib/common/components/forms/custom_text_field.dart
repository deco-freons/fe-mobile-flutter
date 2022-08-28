import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_date_picker.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/event/data/place_model.dart';
import 'package:flutter_boilerplate/page/search_location.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';

class CustomTextField extends StatefulWidget {
  final CustomFormInput input;
  final GlobalKey<FormState> formKey;
  final Color labelColor;
  final TextStyle inputStyle;

  const CustomTextField({
    Key? key,
    required this.input,
    required this.formKey,
    required this.labelColor,
    required this.inputStyle,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _error = false;
  bool _obscured = true;
  bool _confirmObscured = true;

  void toggleVisibility() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  void toggleConfirmVisibility() {
    setState(() {
      _confirmObscured = !_confirmObscured;
    });
  }

  void _selectTime(TextEditingController controller) async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, childWidget) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: childWidget!);
        });
    if (newTime != null) {
      String hour = newTime.hour < 10 ? "0${newTime.hour}" : "${newTime.hour}";
      String minute =
          newTime.minute < 10 ? "0${newTime.minute}" : "${newTime.minute}";
      controller.text = "$hour:$minute";
    }
  }

  void validateField() {
    setState(() {
      _error = !RegExp(widget.input.pattern)
                  .hasMatch(widget.input.controller.text) &&
              widget.input.errorMessage != ''
          ? true
          : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 109.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.input.type != TextFieldType.eventTime
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.input.label,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: widget.labelColor,
                        ),
                      ),
                      widget.input.type == TextFieldType.interest
                          ? CustomTextButton(
                              text: "Add",
                              textWeight: FontWeight.normal,
                              onPressedHandler: () async {
                                List<PrefType>? newPreferences =
                                    await showModalBottomSheet<List<PrefType>>(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40)),
                                  ),
                                  builder: (BuildContext context) {
                                    return AddPreferenceModal(
                                      initialPrefs: widget.input.preferences
                                          .map((pref) => pref.preferenceID)
                                          .toList(),
                                    );
                                  },
                                );
                                if (newPreferences != null) {
                                  List<PreferenceModel> preferenceModels =
                                      newPreferences
                                          .map((pref) => PreferenceModel(
                                              preferenceID: pref.name,
                                              preferenceName: pref.desc))
                                          .toList();
                                  widget.input.setPreferences(preferenceModels);
                                  setState(() {});
                                }
                              })
                          : const SizedBox.shrink(),
                    ],
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(top: 11.0),
              child: widget.input.type == TextFieldType.date
                  ? CustomDatePicker(
                      input: widget.input,
                      firstDate: widget.input.firstDate,
                      lastDate: widget.input.lastDate,
                      inputStyle: widget.inputStyle,
                    )
                  : widget.input.type == TextFieldType.category
                      ? DropdownButtonFormField(
                          style: widget.inputStyle,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: widget.input.disable
                                ? Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.41)
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.21),
                          ),
                          items: PrefType.values.map((preference) {
                            return DropdownMenuItem(
                              value: preference.name,
                              child: Text(preference.desc),
                            );
                          }).toList(),
                          onChanged: (value) {
                            widget.input.controller.text = value.toString();
                          },
                        )
                      : widget.input.type == TextFieldType.eventTime
                          ? Row(
                              children: [
                                buildtimeField(
                                    "Start time", widget.input.controller),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                buildtimeField(
                                    "End time", widget.input.secondController!),
                              ],
                            )
                          : widget.input.type == TextFieldType.location
                              ? TextFormField(
                                  controller: widget.input.controller,
                                  readOnly: true,
                                  style: widget.inputStyle,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: widget.input.disable
                                        ? Theme.of(context)
                                            .colorScheme
                                            .tertiary
                                            .withOpacity(0.41)
                                        : Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.21),
                                    suffixIcon:
                                        const Icon(Icons.place_outlined),
                                  ),
                                  onTap: () async {
                                    PlaceModel location =
                                        await Navigator.pushNamed(
                                      context,
                                      SearchLocation.routeName,
                                    ) as PlaceModel;
                                    widget.input.controller.text =
                                        location.name;
                                    widget.input.lat = location.lat;
                                    widget.input.lng = location.lng;
                                  },
                                )
                              : widget.input.type == TextFieldType.image
                                  ? TextFormField(
                                      controller: widget.input.controller,
                                      readOnly: true,
                                      maxLines: 6,
                                      style: widget.inputStyle,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.21),
                                      ))
                                  : widget.input.type == TextFieldType.interest
                                      ? Wrap(
                                          spacing: 8.0,
                                          runSpacing: 0.0,
                                          children: [
                                              for (PreferenceModel pref
                                                  in widget.input.preferences)
                                                PreferenceButton(
                                                  stringInput:
                                                      pref.preferenceName,
                                                  useStringInput: true,
                                                  cancelIcon: true,
                                                  onPressedHandler: () {
                                                    widget.input
                                                        .removePreferences(
                                                            pref);
                                                    setState(() {});
                                                  },
                                                ),
                                            ])
                                      : TextFormField(
                                          controller: widget.input.controller,
                                          obscureText: widget.input.type ==
                                                  TextFieldType.password
                                              ? _obscured
                                              : false,
                                          readOnly: widget.input.disable,
                                          keyboardType: widget.input.type ==
                                                  TextFieldType.textArea
                                              ? TextInputType.multiline
                                              : TextInputType.text,
                                          maxLines: widget.input.type ==
                                                  TextFieldType.textArea
                                              ? 4
                                              : 1,
                                          style: widget.inputStyle,
                                          decoration: InputDecoration(
                                              hintText: widget.input.type ==
                                                      TextFieldType.textArea
                                                  ? 'Please enter ${widget.input.label} here...'
                                                  : "",
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    width: 1.0,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .error),
                                              ),
                                              border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide.none,
                                              ),
                                              errorText: _error
                                                  ? widget.input.errorMessage
                                                  : null,
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    width: 1.0,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .error),
                                              ),
                                              filled: true,
                                              fillColor: widget.input.disable
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .tertiary
                                                      .withOpacity(0.41)
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.21),
                                              suffixIcon: widget.input.type ==
                                                      TextFieldType.password
                                                  ? _obscured
                                                      ? IconButton(
                                                          icon: const Icon(Icons
                                                              .visibility_off),
                                                          onPressed: () {
                                                            toggleVisibility();
                                                          },
                                                        )
                                                      : IconButton(
                                                          icon: const Icon(
                                                              Icons.visibility),
                                                          onPressed: () {
                                                            toggleVisibility();
                                                          },
                                                        )
                                                  : null),
                                          onChanged: (value) {
                                            widget.input.confirmField
                                                ? widget.formKey.currentState!
                                                    .validate()
                                                : null;
                                            validateField();
                                          },
                                        ),
            ),
            widget.input.confirmField
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Confirm ${widget.input.label}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 11.0,
                      ),
                      TextFormField(
                        controller: widget.input.confirmController,
                        validator: (value) {
                          if (value != widget.input.controller.text) {
                            return 'Have to be the same as your ${widget.input.label}';
                          }
                          return null;
                        },
                        obscureText: widget.input.type == TextFieldType.password
                            ? _confirmObscured
                            : false,
                        style: const TextStyle(
                            fontSize: 16.0, height: 1, color: Colors.black),
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Theme.of(context).colorScheme.error),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide.none,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Theme.of(context).colorScheme.error),
                            ),
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.21),
                            suffixIcon: widget.input.type ==
                                    TextFieldType.password
                                ? _confirmObscured
                                    ? IconButton(
                                        icon: const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          toggleConfirmVisibility();
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () {
                                          toggleConfirmVisibility();
                                        },
                                      )
                                : null),
                        onChanged: (value) {
                          widget.formKey.currentState!.validate();
                        },
                      )
                    ],
                  )
                : const SizedBox(height: 0.0),
          ],
        ),
      ),
    );
  }

  Widget buildtimeField(String label, TextEditingController controller) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: widget.labelColor,
            ),
          ),
          TextFormField(
            controller: controller,
            style: widget.inputStyle,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.21),
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            readOnly: true,
            onTap: () {
              _selectTime(controller);
            },
          ),
        ],
      ),
    );
  }

  // Widget buildModal() {
  //   List<bool> clickCheck = List.filled(PrefType.values.length, true);
  //   List<String> preferenceList = [];

  //   return Container(
  //     height: 410,
  //     padding: const EdgeInsets.only(top: 0.0, left: 21.0, right: 21.0),
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(40), topRight: Radius.circular(40)),
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       // mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Wrap(
  //           spacing: 10.0,
  //           runSpacing: 0.0,
  //           alignment: WrapAlignment.center,
  //           children: [
  //             for (var pref in PrefType.values)
  //               PreferenceButton(
  //                 type: pref,
  //                 onPressedHandler: () {
  //                   setState(() {
  //                     clickCheck[pref.index] = !clickCheck[pref.index];
  //                   });
  //                   if (!clickCheck[pref.index]) {
  //                     preferenceList.add(pref.name);
  //                   } else {
  //                     preferenceList.remove(pref.name);
  //                   }
  //                 },
  //                 click: clickCheck[pref.index],
  //               ),
  //           ],
  //         ),
  //         const SizedBox(height: 53.0),
  //         CustomButton(
  //             label: "Add",
  //             type: ButtonType.primary,
  //             cornerRadius: 32.0,
  //             onPressedHandler: () {}),
  //         const SizedBox(height: 20.0),
  //         CustomTextButton(
  //             text: "Cancel", type: TextButtonType.red, onPressedHandler: () {})
  //       ],
  //     ),
  //   );
  // }
}

class AddPreferenceModal extends StatefulWidget {
  final List<String> initialPrefs;

  AddPreferenceModal({Key? key, List<String>? initialPrefs})
      : initialPrefs = initialPrefs ?? [],
        super(key: key);

  @override
  State<AddPreferenceModal> createState() => _AddPreferenceModalState();
}

class _AddPreferenceModalState extends State<AddPreferenceModal> {
  List<bool> clickCheck = List.filled(PrefType.values.length, true);
  List<PrefType> preferenceList = [];

  @override
  void initState() {
    super.initState();
    for (var pref in PrefType.values) {
      if (widget.initialPrefs.contains(pref.name)) {
        clickCheck[pref.index] = !clickCheck[pref.index];
        preferenceList.add(pref);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      padding: const EdgeInsets.only(top: 0.0, left: 21.0, right: 21.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: 10.0,
            runSpacing: 0.0,
            alignment: WrapAlignment.center,
            children: [
              for (var pref in PrefType.values)
                PreferenceButton(
                  type: pref,
                  onPressedHandler: () {
                    setState(() {
                      clickCheck[pref.index] = !clickCheck[pref.index];
                    });
                    if (!clickCheck[pref.index]) {
                      preferenceList.add(pref);
                    } else {
                      preferenceList.remove(pref);
                    }
                  },
                  click: clickCheck[pref.index],
                ),
            ],
          ),
          const SizedBox(height: 53.0),
          CustomButton(
              label: "Add",
              type: ButtonType.primary,
              cornerRadius: 32.0,
              onPressedHandler: () {
                Navigator.pop(context, preferenceList);
              }),
          const SizedBox(height: 20.0),
          CustomTextButton(
              text: "Cancel",
              type: TextButtonType.error,
              onPressedHandler: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}

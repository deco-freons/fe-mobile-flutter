import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_checkbox_field.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_event_location_field.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_event_time_picker.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_interest_field.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_preference_modal.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_price_field.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_date_picker.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_image_input.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_switch_field.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_text_field.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_user_location_dropdown.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';

class CustomFormField extends StatefulWidget {
  final CustomFormInput input;
  final GlobalKey<FormState> formKey;
  final Color labelColor;
  final TextStyle inputStyle;

  const CustomFormField({
    Key? key,
    required this.input,
    required this.formKey,
    required this.labelColor,
    required this.inputStyle,
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {

  TextStyle customFontStyle(double size) {
    return TextStyle(fontSize: size, fontWeight: FontWeight.bold);
  }

  TextStyle labelStyle() {
    return TextStyle(
      fontSize: CustomFontSize.base,
      fontWeight: FontWeight.bold,
      color: widget.labelColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: CustomPadding.base),
      child: widget.input.type == TextFieldType.checkbox
          ? CustomCheckboxField(input: widget.input)
          : widget.input.type == TextFieldType.toggleSwitch
              ? CustomSwitchField(
                  input: widget.input,
                  labelStyle: customFontStyle(CustomFontSize.sm),
                  inputStyle: customFontStyle(CustomFontSize.xs))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.input.label.isNotEmpty
                        ? widget.input.type != TextFieldType.eventTime
                            ? buildLabelRow()
                            : const SizedBox.shrink()
                        : const SizedBox.shrink(),
                    SizedBox(
                        height: widget.input.label.isNotEmpty
                            ? CustomPadding.base
                            : 0),
                    widget.input.type == TextFieldType.date
                        ? CustomDatePicker(
                            input: widget.input,
                            firstDate: widget.input.firstDate,
                            lastDate: widget.input.lastDate,
                            inputStyle: widget.inputStyle,
                          )
                        : widget.input.type == TextFieldType.suburbDropdown
                            ? CustomUserLocationDropdown(
                                input: widget.input,
                                inputStyle: widget.inputStyle)
                            : widget.input.type == TextFieldType.eventTime
                                ? CustomEventTimePicker(
                                    input: widget.input,
                                    labelStyle: labelStyle(),
                                    inputStyle: widget.inputStyle)
                                : widget.input.type == TextFieldType.location
                                    ? CustomEventLocationField(
                                        input: widget.input,
                                        inputStyle: widget.inputStyle,
                                      )
                                    : widget.input.type ==
                                            TextFieldType.eventImage
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomImageInput(
                                                customFormInput: widget.input,
                                                icon: Icon(
                                                  Icons.add_a_photo_rounded,
                                                  color: neutral.shade200,
                                                  size: 60,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: CustomPadding.sm,
                                              ),
                                              Text(
                                                "Image cannot exceed 3MB (jpg, jpeg, png)",
                                                style: TextStyle(
                                                  fontSize: CustomFontSize.xs,
                                                  color: neutral.shade500,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          )
                                        : widget.input.type ==
                                                TextFieldType.profileImage
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomImageInput(
                                                    radius: 100,
                                                    width: 125,
                                                    height: 125,
                                                    customFormInput:
                                                        widget.input,
                                                    icon: Icon(
                                                      Icons.person,
                                                      color: neutral.shade100,
                                                      size: 100,
                                                    ),
                                                    overlayWidget: Positioned(
                                                      right: CustomPadding.sm,
                                                      bottom: CustomPadding.md,
                                                      child: Icon(
                                                        Icons
                                                            .camera_alt_rounded,
                                                        size: 32,
                                                        color: neutral.shade200,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: CustomPadding.lg,
                                                  ),
                                                  Text(
                                                    "Image cannot exceed 3MB (jpg, jpeg, png)",
                                                    style: TextStyle(
                                                      fontSize:
                                                          CustomFontSize.xs,
                                                      color: neutral.shade500,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              )
                                            : widget.input.type ==
                                                    TextFieldType.price
                                                ? CustomPriceField(
                                                    input: widget.input,
                                                    inputStyle:
                                                        widget.inputStyle,
                                                    formKey: widget.formKey)
                                                : widget.input.type ==
                                                        TextFieldType.interest
                                                    ? CustomInterestField(
                                                        input: widget.input,
                                                        inputStyle:
                                                            customFontStyle(
                                                                CustomFontSize
                                                                    .base),
                                                      )
                                                    : CustomTextField(
                                                        input: widget.input,
                                                        inputStyle:
                                                            widget.inputStyle,
                                                        formKey: widget.formKey,
                                                      )
                  ],
                ),
    );
  }

  Widget buildLabelRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.input.label,
          style: labelStyle(),
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
                          topLeft: Radius.circular(CustomRadius.body),
                          topRight: Radius.circular(CustomRadius.body)),
                    ),
                    builder: (BuildContext context) {
                      return CustomPreferenceModal(
                        initialPrefs: widget.input.preferences
                            .map((pref) => pref.preferenceID)
                            .toList(),
                      );
                    },
                  );
                  if (newPreferences != null) {
                    List<PreferenceModel> preferenceModels = newPreferences
                        .map((pref) => PreferenceModel(
                            preferenceID: pref.name, preferenceName: pref.desc))
                        .toList();
                    widget.input.setPreferences(preferenceModels);
                    setState(() {});
                  }
                })
            : const SizedBox.shrink(),
      ],
    );
  }
}

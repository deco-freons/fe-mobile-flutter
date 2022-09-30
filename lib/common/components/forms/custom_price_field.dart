import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_toggle_buttons.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/item_filter_model.dart';

class CustomPriceField extends StatefulWidget {
  final CustomFormInput input;
  final TextStyle inputStyle;
  final GlobalKey<FormState> formKey;
  const CustomPriceField({
    Key? key,
    required this.input,
    required this.inputStyle,
    required this.formKey,
  }) : super(key: key);

  @override
  State<CustomPriceField> createState() => _CustomPriceFieldState();
}

class _CustomPriceFieldState extends State<CustomPriceField> {
  List<ItemFilterModel<String>> options = const [
    ItemFilterModel(data: "Paid", isPicked: true),
    ItemFilterModel(data: "Free")
  ];

  void toggleButtonHandle(int index) {
    setState(() {
      options = options.map((option) {
        if (options[index].data == option.data) {
          return option.copyWith(isPicked: true);
        } else {
          return option.copyWith(isPicked: false);
        }
      }).toList();

      if (options[index].data == 'Free') {
        widget.input.setDisable(true);
        widget.input.controller.text = "";
      } else if (options[index].data == 'Paid') {
        widget.input.setDisable(false);
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomToggleButtons(
          options: options,
          onPressed: toggleButtonHandle,
        ),
        const SizedBox(
          height: CustomPadding.lg,
        ),
        TextFormField(
          controller: widget.input.controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
          ],
          readOnly: widget.input.disable,
          style: widget.inputStyle,
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                  width: 1.0, color: Theme.of(context).colorScheme.error),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                  width: 1.0, color: Theme.of(context).colorScheme.error),
            ),
            filled: true,
            fillColor: widget.input.disable
                ? Theme.of(context).colorScheme.tertiary.withOpacity(0.41)
                : primary.shade300,
            isDense: true,
            prefixIcon: Text(
              "  \$ ",
              style: TextStyle(
                fontSize: CustomFontSize.lg,
                fontWeight: FontWeight.bold,
                color: neutral.shade600,
              ),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
        ),
      ],
    );
  }
}

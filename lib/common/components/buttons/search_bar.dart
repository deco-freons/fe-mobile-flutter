import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class SearchBar extends StatelessWidget {
  final String label;
  final bool hasSecondIcon;
  final Widget secondIcon;
  final VoidCallback iconOnPressedHandler;
  final TextEditingController textEditingController;
  const SearchBar({
    Key? key,
    required this.label,
    this.hasSecondIcon = false,
    this.secondIcon = const Text(''),
    required this.iconOnPressedHandler,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: textEditingController,
        decoration: InputDecoration(
            isCollapsed: true,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: hasSecondIcon
                ? IconButton(
                    icon: secondIcon,
                    onPressed: iconOnPressedHandler,
                  )
                : null,
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(color: neutral.shade300),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: primary.shade300),
      ),
    );
  }
}

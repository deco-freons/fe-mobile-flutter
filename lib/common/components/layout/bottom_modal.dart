import 'package:flutter/material.dart';

class BottomModal {
  static void showBaseModalBottomSheet(
      {required BuildContext context,
      required Widget Function(BuildContext) builder}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      context: context,
      builder: builder,
    );
  }
}

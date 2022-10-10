import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class BottomModal {
  static Future<T?> showBaseModalBottomSheet<T>(
      {required BuildContext context,
      required Widget Function(BuildContext) builder}) {
    return showModalBottomSheet<T>(
      isScrollControlled: true,
      backgroundColor: neutral.shade100,
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

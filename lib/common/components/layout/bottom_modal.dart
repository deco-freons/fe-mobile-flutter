import 'package:flutter/material.dart';

class BottomModal {
  static void baseModalBottomSheet(
      {required BuildContext context, required child}) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        context: context,
        builder: (BuildContext bc) => child);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/confirmation_modal_bottom.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class LeaveConfirmationModal extends StatelessWidget {
  final VoidCallback onLeavePressed;
  const LeaveConfirmationModal({Key? key, required this.onLeavePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationModalBottom(
      description: "Are you sure you want to leave this event?",
      confirmText: "Leave",
      confirmButtonType: TextButtonType.error,
      onConfirmPressed: onLeavePressed,
      cancelText: "Cancel",
      cancelButtonType: TextButtonType.tertiaryDark,
      onCancelPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

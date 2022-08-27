import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/confirmation_modal_bottom.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail_cubit.dart';

class LeaveBottomModal extends StatelessWidget {
  final int eventID;
  final BuildContext blocContext;
  const LeaveBottomModal(
      {Key? key, required this.eventID, required this.blocContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 25),
      height: 185,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextButton(
            text: "Leave",
            onPressedHandler: () {
              showModalBottomSheet(
                barrierColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                context: context,
                builder: (context) {
                  return ConfirmationModalBottom(
                    description: "Are you sure you want to leave this event?",
                    confirmText: "Leave",
                    confirmButtonType: TextButtonType.error,
                    onConfirmPressed: () {
                      blocContext
                          .read<EventDetailCubit>()
                          .leaveEvent(eventID)
                          .then((value) {
                        NavigatorUtil.goBacknTimes(context, 2);
                      });
                    },
                    cancelText: "Cancel",
                    cancelButtonType: TextButtonType.tertiaryDark,
                    onCancelPressed: () {
                      NavigatorUtil.goBacknTimes(context, 2);
                    },
                  );
                },
              );
            },
            fontSize: 20,
            type: TextButtonType.error,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            label: "Close",
            cornerRadius: 32,
            type: ButtonType.primary,
            onPressedHandler: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

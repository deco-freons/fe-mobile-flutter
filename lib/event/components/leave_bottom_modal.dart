import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/layout/confirmation_modal_bottom.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';

class LeaveBottomModal extends StatelessWidget {
  final int eventID;
  const LeaveBottomModal({Key? key, required this.eventID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UpdateEventDetailCubit(getIt.get<EventDetailRepository>()),
      child: BlocBuilder<UpdateEventDetailCubit, UpdateEventDetailState>(
        builder: (blocContext, state) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: CustomPadding.xxl, vertical: CustomPadding.xl),
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
                          description:
                              "Are you sure you want to leave this event?",
                          confirmText: "Leave",
                          confirmButtonType: TextButtonType.error,
                          onConfirmPressed: () {
                            blocContext
                                .read<UpdateEventDetailCubit>()
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
                  cornerRadius: CustomRadius.button,
                  type: ButtonType.primary,
                  onPressedHandler: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

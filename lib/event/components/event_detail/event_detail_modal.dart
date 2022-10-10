import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_component.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/layout/bottom_modal.dart';
import 'package:flutter_boilerplate/common/components/layout/confirmation_modal_bottom.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/common/utils/typedef.dart';
import 'package:flutter_boilerplate/event/bloc/update_event/update_event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/update_event/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/components/event_detail/edit_bottom_modal.dart';
import 'package:flutter_boilerplate/event/components/event_detail/leave_confirmation_modal.dart';
import 'package:flutter_boilerplate/event/components/event_detail/report_bottom_modal.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_repository.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_response_model.dart';
import 'package:flutter_boilerplate/get_it.dart';

class EventDetailBottomModal {
  static void showLeaveConfirmationModal(
      {required BuildContext context, required VoidCallback onLeavePressed}) {
    BottomModal.showBaseModalBottomSheet(
        context: context,
        builder: (ctx) {
          return LeaveConfirmationModal(onLeavePressed: onLeavePressed);
        });
  }

  static void showDeleteConfirmationModal(
      {required BuildContext context, required int eventID}) {
    BottomModal.showBaseModalBottomSheet(
        context: context,
        builder: (ctx) {
          return BlocProvider(
            create: (context) =>
                UpdateEventDetailCubit(getIt.get<EventDetailRepository>()),
            child: BlocBuilder<UpdateEventDetailCubit, UpdateEventDetailState>(
              builder: (blocContext, state) {
                return ConfirmationModalBottom(
                  description: "Are you sure you want to delete this event?",
                  confirmText: "Delete",
                  confirmButtonType: TextButtonType.error,
                  onConfirmPressed: () async {
                    await blocContext
                        .read<UpdateEventDetailCubit>()
                        .deleteEvent(eventID);
                  },
                  cancelText: "Cancel",
                  cancelButtonType: TextButtonType.tertiaryDark,
                  onCancelPressed: () {
                    NavigatorUtil.goBacknTimes(context, 2);
                  },
                );
              },
            ),
          );
        });
  }

  static Future<void> showReportConfirmed(
      {required BuildContext context}) async {
    BottomModal.showBaseModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: const EdgeInsets.only(bottom: CustomPadding.md),
            height: 340,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: neutral.shade100,
                    size: 96,
                  ),
                ),
                const SizedBox(
                  height: CustomPadding.xxxl,
                ),
                Text(
                  "Thanks for letting us know!",
                  style: TextStyle(
                    fontSize: 22,
                    color: neutral.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: CustomPadding.xl,
                ),
                CustomTextButton(
                    text: "Close",
                    type: TextButtonType.error,
                    fontSize: CustomFontSize.base,
                    onPressedHandler: () {
                      NavigatorUtil.goBacknTimes(ctx, 2);
                    }),
              ],
            ),
          );
        });
  }

  static Future<bool?> showReportFormModal(
      {required BuildContext context}) async {
    CustomFormInput reportDescription = CustomFormInput(
      label: "Why are you reporting this event?",
      placeholder: "Write here...",
      type: TextFieldType.textArea,
    );
    return BottomModal.showBaseModalBottomSheet<bool?>(
        context: context,
        builder: (ctx) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.only(top: CustomPadding.xxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Report",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: CustomFontSize.xl,
                        color: neutral.shade700),
                  ),
                  CustomForm(
                      inputs: [reportDescription],
                      submitTitle: "Save",
                      submitHandler: () {
                        Navigator.pop<bool?>(context, true);
                      },
                      textButton: "Cancel",
                      textButtonType: TextButtonType.error,
                      secondaryActionPadding: CustomPadding.md,
                      bottomPadding: CustomPadding.md,
                      textButtonHandler: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ),
          );
        });
  }

  static void showReportOrEditModal({
    required BuildContext context,
    required EventDetailResponseModel eventDetail,
    required bool isEventCreator,
    required CustomVoidCallback<bool> reportEvent,
    required bool isReported,
  }) async {
    BottomModal.showBaseModalBottomSheet(
        context: context,
        builder: (ctx) {
          return isEventCreator
              ? EditBottomModal(eventDetail: eventDetail)
              : ReportBottomModal(
                  reportEvent: reportEvent,
                  isReported: isReported,
                );
        });
  }
}

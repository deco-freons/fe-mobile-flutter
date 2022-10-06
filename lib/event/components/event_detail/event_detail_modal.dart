import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/layout/bottom_modal.dart';
import 'package:flutter_boilerplate/common/components/layout/confirmation_modal_bottom.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
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

  static void showReportOrEditModal(
      {required BuildContext context,
      required EventDetailResponseModel eventDetail,
      required bool isEventCreator}) {
    BottomModal.showBaseModalBottomSheet(
        context: context,
        builder: (ctx) {
          return isEventCreator
              ? EditBottomModal(eventDetail: eventDetail)
              : const ReportBottomModal();
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/components/confirmation_modal_bottom.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/page/edit_event.dart';

import '../../common/components/buttons/custom_button.dart';

class EditBottomModal extends StatelessWidget {
  final EventDetailResponseModel eventDetail;
  const EditBottomModal({Key? key, required this.eventDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: CustomPadding.xxl, vertical: CustomPadding.xl),
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextButton(
              text: "Edit",
              fontSize: CustomFontSize.lg,
              type: TextButtonType.tertiaryDark,
              onPressedHandler: () {
                Navigator.pushNamed(context, EditEvent.routeName,
                    arguments: eventDetail);
              }),
          CustomTextButton(
            text: "Delete",
            fontSize: CustomFontSize.lg,
            type: TextButtonType.error,
            onPressedHandler: () {
              showDeleteConfirmation(context);
            },
          ),
          const SizedBox(
            height: 23,
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
  }

  showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      context: context,
      builder: (context) {
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
                      .deleteEvent(eventDetail.event.eventID);
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
      },
    );
  }
}

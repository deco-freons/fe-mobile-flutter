import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/components/event_detail/event_detail_modal.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_response_model.dart';
import 'package:flutter_boilerplate/page/event/edit_event.dart';

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
    EventDetailBottomModal.showDeleteConfirmationModal(
        context: context, eventID: eventDetail.event.eventID);
  }
}

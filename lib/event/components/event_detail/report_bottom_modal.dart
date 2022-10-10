import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/typedef.dart';
import 'package:flutter_boilerplate/event/components/event_detail/event_detail_modal.dart';

class ReportBottomModal extends StatelessWidget {
  final CustomVoidCallback<bool> reportEvent;
  final bool isReported;

  const ReportBottomModal(
      {Key? key, required this.reportEvent, required this.isReported})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: CustomPadding.xxl, vertical: CustomPadding.xl),
      height: 185,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextButton(
            text: isReported ? "Event Reported" : "Report Event",
            fontSize: 20,
            type: isReported
                ? TextButtonType.tertiary
                : TextButtonType.tertiaryDark,
            onPressedHandler: () async {
              if (isReported) return;
              final res = await EventDetailBottomModal.showReportFormModal(
                  context: context);

              if (res != null) {
                reportEvent(true);
                await EventDetailBottomModal.showReportConfirmed(
                    context: context);
              }
            },
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
  }
}

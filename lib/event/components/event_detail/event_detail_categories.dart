import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_chip.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_model.dart';

class EventDetailCategories extends StatelessWidget {
  final EventDetailModel event;
  const EventDetailCategories({Key? key, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
          direction: Axis.horizontal,
          spacing: CustomPadding.md,
          children: [
            CustomChip(
              color: success,
              label: event.eventPrice.fee > 0
                  ? '\$${event.eventPrice.fee}'
                  : 'FREE',
              width: null,
              height: null,
              padding: const EdgeInsets.symmetric(
                vertical: CustomPadding.sm,
                horizontal: CustomPadding.md,
              ),
            ),
            ...event.categories
                .map((category) => CustomChip(
                      label: category.preferenceName,
                      fontColor: neutral.shade700,
                      color: primary.shade300,
                      width: null,
                      height: null,
                      padding: const EdgeInsets.symmetric(
                        vertical: CustomPadding.sm,
                        horizontal: CustomPadding.base,
                      ),
                    ))
                .toList(),
          ]),
    );
  }
}

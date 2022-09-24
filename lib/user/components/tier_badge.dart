import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class TierBadge extends StatelessWidget {
  final int eventCount;
  const TierBadge({Key? key, required this.eventCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: eventCount >= BadgeTier.GOLD.id
            ? BadgeTier.GOLD.color
            : eventCount >= BadgeTier.SILVER.id
                ? BadgeTier.SILVER.color
                : BadgeTier.BRONZE.color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        eventCount >= BadgeTier.GOLD.id
            ? BadgeTier.GOLD.desc
            : eventCount >= BadgeTier.SILVER.id
                ? BadgeTier.SILVER.desc
                : BadgeTier.BRONZE.desc,
        style: TextStyle(
          fontSize: CustomFontSize.base,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

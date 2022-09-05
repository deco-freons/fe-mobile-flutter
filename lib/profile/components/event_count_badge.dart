import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class EventCountBadge extends StatelessWidget {
  final int eventCount;
  const EventCountBadge({Key? key, required this.eventCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomPadding.base),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(CustomRadius.xxl)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageIcon(const AssetImage('lib/common/assets/images/TrophyIcon.png'),
              color: Theme.of(context).colorScheme.secondary),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            "$eventCount events",
            style: TextStyle(
              fontSize: CustomFontSize.base,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

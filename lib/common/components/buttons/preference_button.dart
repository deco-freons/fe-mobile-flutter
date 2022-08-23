import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class PreferenceButton extends StatefulWidget {
  final PrefButtonType type;
  final VoidCallback onPressedHandler;
  final double cornerRadius;
  final bool click;

  const PreferenceButton({
    Key? key,
    required this.type,
    required this.onPressedHandler,
    this.cornerRadius = 50.0,
    this.click = true,
  }) : super(key: key);

  @override
  State<PreferenceButton> createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          primary: (widget.click)
              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
              : Theme.of(context).colorScheme.primary,
          onPrimary: (widget.click)
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.cornerRadius)),
          )),
      onPressed: widget.onPressedHandler,
      child: Text(
        (widget.type == PrefButtonType.gaming)
            ? "🎮 Gaming"
            : (widget.type == PrefButtonType.movie)
                ? "🎬 Movie"
                : (widget.type == PrefButtonType.dancing)
                    ? "💃️ Dancing"
                    : (widget.type == PrefButtonType.culinary)
                        ? "🍽 Culinary"
                        : (widget.type == PrefButtonType.basketball)
                            ? "🏀 Basketball"
                            : (widget.type == PrefButtonType.nature)
                                ? "🍃️ Nature"
                                : (widget.type == PrefButtonType.football)
                                    ? "⚽️ Football"
                                    : "All",
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

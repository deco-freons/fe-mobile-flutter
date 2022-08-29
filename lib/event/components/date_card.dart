import 'package:flutter/material.dart';

class DateCard extends StatefulWidget {
  final String month;
  final String date;

  const DateCard({
    Key? key,
    required this.month,
    required this.date,
  }) : super(key: key);

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: SizedBox(
        width: 35.0,
        height: 35.0,
        child: Column(children: [
          Text(
            widget.month,
            style: const TextStyle(fontSize: 10.0),
          ),
          Text(
            widget.date,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ]),
      ),
    );
  }
}

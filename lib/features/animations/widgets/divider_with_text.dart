import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Divider(
            height: 80,
            thickness: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            height: 80,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
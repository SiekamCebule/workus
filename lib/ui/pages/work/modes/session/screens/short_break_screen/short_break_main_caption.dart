import 'package:flutter/material.dart';

class ShortBreakMainCaption extends StatelessWidget {
  const ShortBreakMainCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Text(
        'Odejdź na chwilę od pracy i odpręż się...',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

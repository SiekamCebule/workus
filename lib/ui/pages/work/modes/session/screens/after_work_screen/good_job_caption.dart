import 'package:flutter/material.dart';

class GoodJobCaption extends StatelessWidget {
  const GoodJobCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Dobra robota!',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

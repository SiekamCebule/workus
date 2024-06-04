import 'package:flutter/material.dart';

class MultiplyAndClampCurve extends Curve {
  const MultiplyAndClampCurve(this.multiplier);

  final double multiplier;

  @override
  double transform(double t) {
    double value = t * multiplier;
    if (value > 1.0) return 1.0;
    return value;
  }
}

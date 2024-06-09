import 'package:flutter/material.dart';

enum LayoutType {
  verticalPhone,
  horizontalPhone,
  verticalTablet,
  horizontalTablet,
  desktop;

  static LayoutType fromConstraints(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;

    if (width < 470 && height < 900) {
      return LayoutType.verticalPhone;
    } else if (width < 900 && height < 470) {
      return LayoutType.horizontalPhone;
    } else if (width < 1400 && height < 900) {
      return LayoutType.verticalTablet;
    } else if (width < 90 && height < 1400) {
      return LayoutType.horizontalTablet;
    } else {
      return LayoutType.desktop;
    }
  }
}

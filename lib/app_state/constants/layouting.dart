import 'package:flutter/material.dart';

enum LayoutType {
  verticalPhone,
  horizontalPhone,
  verticalTablet,
  horizontalTablet,
  foldSquare,
  desktop;

  static LayoutType fromConstraints(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;

    if (width < 470 && height < 900) {
      return LayoutType.verticalPhone;
    } else if (width < 900 && height < 530) {
      return LayoutType.horizontalPhone;
    } else if (width < 900 && height < 720) {
      return LayoutType.foldSquare;
    } else if (width < 900 && height < 1400) {
      return LayoutType.verticalTablet;
    } else if (width < 1400 && height < 900) {
      return LayoutType.horizontalTablet;
    } else {
      return LayoutType.desktop;
    }
  }
}

bool shouldShowNavigationRail(LayoutType type) {
  if (type == LayoutType.horizontalTablet ||
      type == LayoutType.horizontalPhone ||
      type == LayoutType.desktop) {
    return true;
  } else {
    return false;
  }
}

bool shouldShowLargePlayPauseButton(LayoutType type) {
  if (type case LayoutType.horizontalTablet || LayoutType.verticalTablet) {
    return true;
  } else {
    return false;
  }
}

TextStyle? textStyleForRemainingTimeLabel(LayoutType type, BuildContext context) {
  if (type == LayoutType.horizontalPhone) {
    return Theme.of(context).textTheme.headlineMedium;
  } else if (type == LayoutType.verticalPhone) {
    return Theme.of(context).textTheme.headlineLarge;
  } else {
    return Theme.of(context).textTheme.displaySmall;
  }
}

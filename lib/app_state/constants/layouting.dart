enum LayoutType {
  small,
  medium,
  large;

  static LayoutType fromWidth(double width) {
    return switch (width) {
      <= 600 => LayoutType.small,
      <= 1000 => LayoutType.medium,
      _ => LayoutType.large,
    };
  }
}

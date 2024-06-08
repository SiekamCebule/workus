enum LayoutType {
  small,
  large;

  static LayoutType byWidth(double width) {
    return switch (width) {
      <= 600 => LayoutType.small,
      _ => LayoutType.large,
    };
  }
}

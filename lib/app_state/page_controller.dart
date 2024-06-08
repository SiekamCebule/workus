import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageControllerNotiifer extends Notifier<PageController> {
  @override
  PageController build() {
    return PageController(initialPage: 1);
  }

  Future<void> animateToPage(int page) async {
    state.animateToPage(page, duration: Durations.short4, curve: Curves.ease);
  }
}

final pageControllerProvider =
    NotifierProvider<PageControllerNotiifer, PageController>(
  () => PageControllerNotiifer(),
);

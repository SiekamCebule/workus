import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPageProvider = StateProvider<AppPage>(
  (ref) => AppPage.work,
);

enum AppPage {
  tasks,
  work,
  settings;

  static AppPage fromIndex(int index) {
    return AppPage.values[index];
  }
}

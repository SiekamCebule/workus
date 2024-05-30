import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/task_statuses_notifier.dart';

@GenerateMocks([TaskStatusesNotifier])
void main() {
  group('task_statuses_notifier', () {
    test('_f', body)
    final notifier = TaskStatusesNotifier(taskType: TaskType.beforeSession);
  });
}

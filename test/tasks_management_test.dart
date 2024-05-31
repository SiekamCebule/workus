import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/task_statuse_notifier/task_statuses_notifier.dart';
import 'package:workus/providers/tasks.dart';

@GenerateMocks([TaskStatusesNotifier])
void main() {
  const type = TaskType.beforeSession;
  group('TasksNotifier provider', () {
    late final NotifierProvider<TasksNotifier, List<Task>> tasksProvider;
    late final ProviderContainer ref;
    setUp(() {
      tasksProvider = NotifierProvider(() => TasksNotifier());
      ref = ProviderContainer();
    });
    test('adding, removing and updating', () {
      ref.read(tasksProvider.notifier).add(
            const Task(title: 'task zerowy', type: type, id: 0),
          );
      ref.read(tasksProvider.notifier).add(
            const Task(title: 'task pierwszy', type: type, id: 1),
          );
      ref.read(tasksProvider.notifier).add(
            const Task(title: 'task drugi', type: type, id: 2),
          );
      ref.read(tasksProvider.notifier).remove(
            ref.read(tasksProvider).first,
          );
      ref.read(tasksProvider.notifier).remove(
            ref.read(tasksProvider).last,
          );
      ref.read(tasksProvider.notifier).add(
            ref.read(tasksProvider).last.copyWith(id: 2),
          );
      ref.read(tasksProvider.notifier).update(
            ref.read(tasksProvider.notifier).byId(1),
            const Task(title: 'fajny task', type: type, id: 1),
          );

      expect(ref.read(tasksProvider).length, 2);
      expect(ref.read(tasksProvider), [
        const Task(title: 'fajny task', type: type, id: 1),
        const Task(title: 'task pierwszy', type: type, id: 2),
      ]);
    });
  });
  group('TaskStatusesNotifier provider', () {
    late final NotifierProvider<TasksNotifier, List<Task>> tasksProvider;
    late final NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>
        taskStatusesProvider;
    late final ProviderContainer ref;
    setUp(() {
      tasksProvider = NotifierProvider(() => TasksNotifier());
      taskStatusesProvider = NotifierProvider(
        () => TaskStatusesNotifier(tasksProvider: tasksProvider),
      );
      ref = ProviderContainer();
    });

    List<Task> tasks() => ref.read(tasksProvider);
    Map<Task, bool> statuses() => ref.read(taskStatusesProvider);
    void add(Task t) {
      ref.read(tasksProvider.notifier).add(t);
    }

    void update(Task t, bool c) {
      ref.read(taskStatusesProvider.notifier).update(t, completed: c);
    }

    void toggle(Task t) => ref.read(taskStatusesProvider.notifier).toggle(t);

    void remove(Task t) => ref.read(tasksProvider.notifier).remove(t);

    test('adding, removing and updating', () {
      ref.read(tasksProvider.notifier).updateAll(
        const [
          Task(title: 'task pierwszy', type: type, id: 0),
          Task(title: 'task drugi', type: type, id: 1),
          Task(title: 'task trzeci', type: type, id: 2),
        ],
      );
      update(tasks()[0], true);
      update(tasks()[1], true);
      remove(tasks()[0]);
      expect(statuses(), {
        const Task(title: 'task drugi', type: type, id: 1): true,
        const Task(title: 'task trzeci', type: type, id: 2): false,
      });
      add(const Task(title: 'task zerowy', type: type, id: -1));
      add(const Task(title: 'task czwarty', type: type, id: 3));
      expect(statuses(), {
        const Task(title: 'task zerowy', type: type, id: -1): false,
        const Task(title: 'task drugi', type: type, id: 1): true,
        const Task(title: 'task trzeci', type: type, id: 2): false,
        const Task(title: 'task czwarty', type: type, id: 3): false,
      });
      update(const Task(title: 'task zerowy', type: type, id: -1), true);
      toggle(const Task(title: 'task drugi', type: type, id: 1));
      toggle(const Task(title: 'task czwarty', type: type, id: 3));
      toggle(const Task(title: 'task czwarty', type: type, id: 3));
      expect(statuses(), {
        const Task(title: 'task zerowy', type: type, id: -1): true,
        const Task(title: 'task drugi', type: type, id: 1): false,
        const Task(title: 'task trzeci', type: type, id: 2): false,
        const Task(title: 'task czwarty', type: type, id: 3): false,
      });
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task_type.dart';

final selectedTaskTypeProvider =
    StateProvider<TaskType>((ref) => TaskType.beforeWork);

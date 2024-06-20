import 'package:path_provider/path_provider.dart';
import 'package:workus/models/task_type.dart';

Future<String> tasksPath(TaskType type) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  return '$path/workus/tasks_${type.name}.json';
}

dynamic elementById(Iterable<dynamic> tasks, Object id) {
  try {
    return tasks.firstWhere((task) => task.id == id);
  } on StateError {
    return null;
  }
}

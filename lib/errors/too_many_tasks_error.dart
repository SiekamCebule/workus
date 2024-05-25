class TooManyTasksError extends Error {
  TooManyTasksError([this.content]);

  String? content;

  @override
  String toString() {
    return 'TooManyTasksError: ${content ?? '(no content)'}';
  }
}

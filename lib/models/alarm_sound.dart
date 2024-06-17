class AlarmSound {
  const AlarmSound({
    required this.id,
    required this.filePath,
    required this.name,
  });

  final String id;
  final String filePath;
  final String name;

  @override
  String toString() {
    return '$name ($id)';
  }
}

class AlarmSound {
  const AlarmSound({
    required this.id,
    required this.filePath,
  });

  final String id;
  final String filePath;

  @override
  String toString() {
    return 'An alarm sound with id of $id';
  }
}

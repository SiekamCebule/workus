enum TaskType {
  beforeWork,
  duringMiniBreak,
  afterWork;

  static TaskType fromIndex(int index) => values[index];
}

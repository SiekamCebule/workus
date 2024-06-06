const maxTasksCountInCategory = 3;

const minSessionDuration = Duration(minutes: 10);
const maxSessionDuration = Duration(minutes: 300);
const sessionDurationInterval = Duration(minutes: 10);

const minShortBreakDuration = Duration.zero;
const maxShortBreakDuration = Duration(minutes: 90);
const shortBreakDurationInterval = Duration(minutes: 10);

const defaultShortBreaksIntervalChoices = [
  Duration(minutes: 10),
  Duration(minutes: 20),
  Duration(minutes: 30),
  Duration(minutes: 40),
  Duration(minutes: 50),
  Duration(minutes: 60),
  Duration(minutes: 90),
];

const defaultSessionDurationChoices = [
  Duration(minutes: 15),
  Duration(minutes: 30),
  Duration(minutes: 60),
  Duration(minutes: 120),
  Duration(minutes: 180),
  Duration(minutes: 240),
];

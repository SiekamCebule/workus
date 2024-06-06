part of 'alarm_player.dart';

class _FadeVolumeStreamer {
  VoidCallback? onEnd;

  Stream<double> startFading({
    required Duration fadeDuration,
    required double Function(int step, double volumeStep) calculateVolume,
    bool reverse = false,
  }) {
    final subject = PublishSubject<double>();
    final steps = fadeDuration.inMilliseconds ~/ 100;
    final stepDuration = fadeDuration * (1 / steps);
    final volumeStep = 1 / steps;

    final stepsStream = createStepsStream(steps: steps, shouldReverse: reverse);
    final fadeSteps = stepsStream.interval(stepDuration);

    fadeSteps.listen(
      (index) async {
        final volume = calculateVolume(index, volumeStep);
        subject.add(volume);
      },
      onDone: () {
        subject.close();
      },
    );
    return subject;
  }

  Stream<int> createStepsStream({required int steps, bool shouldReverse = false}) {
    var stepsStream = RangeStream(0, steps - 1);
    if (shouldReverse) {
      return stepsStream.map((stepIndex) {
        return steps - stepIndex - 1;
      });
    } else {
      return stepsStream;
    }
  }
}

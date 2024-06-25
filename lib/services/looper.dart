import 'dart:async';

class LoopingService {
  Future<void> startLooping<T>(
    List<T> items,
    Duration delay,
    Future<void> Function(T item) onItemLoop,
  ) async {
    int idx = 0;

    void loop() async {
      print("index: $idx");
      await onItemLoop(items[idx]);
      idx = (idx + 1) % items.length;
      // await Future.delayed(delay);
      await delayWithCountdown(delay);
      loop();
    }

    loop();
  }

  Future<void> delayWithCountdown(Duration delay) async {
    int delayInSeconds = delay.inSeconds;
    Completer<void> completer = Completer<void>();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print('${delayInSeconds - timer.tick} seconds left');
      if (timer.tick >= delayInSeconds) {
        timer.cancel();
        completer.complete();
      }
    });
    return completer.future;
  }
}

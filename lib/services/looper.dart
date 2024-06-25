import 'dart:async';

/// Manages looping through a list of items with a specified delay,
/// executing a callback function on each item.
class LoopingService {
  Timer? _loopTimer;
  bool _isLooping = false;

  Future<void> startLooping<T>(
    List<T> items,
    Duration delay,
    Future<void> Function(T item) onItemLoop,
  ) async {
    int idx = 0;
    _isLooping = true;

    void loop() async {
      if (!_isLooping) return;

      await onItemLoop(items[idx]);
      idx = (idx + 1) % items.length;
      await delayWithCountdown(delay);
      loop();
    }

    loop();
  }

  Future<void> delayWithCountdown(Duration delay) async {
    int delayInSeconds = delay.inSeconds;
    Completer<void> completer = Completer<void>();
    _loopTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isLooping) {
        timer.cancel();
        completer.complete();
        return;
      }
      print('${delayInSeconds - timer.tick} seconds left');
      if (timer.tick >= delayInSeconds) {
        timer.cancel();
        completer.complete();
      }
    });
    return completer.future;
  }

  void stopLooping() {
    _isLooping = false;
    _loopTimer?.cancel();
  }
}

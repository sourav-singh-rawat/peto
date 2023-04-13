part of 'helper.dart';

class KThrottle {
  final Duration duration;

  Timer? timer;

  KThrottle({
    required this.duration,
  });

  void call(VoidCallback func) {
    if (timer?.isActive ?? false) return;

    timer?.cancel();
    func();
    timer = Timer(duration, () {});
  }

  void dispose() {
    timer?.cancel();
  }
}

part of 'app_booter_cubit.dart';

enum AppBooterStatus { booting, booted }

class _KAppBooterState {
  final AppBooterStatus status;

  _KAppBooterState({
    required this.status,
  });

  _KAppBooterState.init()
      : this(
          status: AppBooterStatus.booting,
        );

  _KAppBooterState copyWith({AppBooterStatus? status}) {
    return _KAppBooterState(
      status: status ?? this.status,
    );
  }
}

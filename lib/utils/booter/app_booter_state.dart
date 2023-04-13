part of 'app_booter_cubit.dart';

enum AppBooterStatus { booting, booted }

class KAppBooterState {
  final AppBooterStatus status;

  KAppBooterState({
    required this.status,
  });

  KAppBooterState.init()
      : this(
          status: AppBooterStatus.booting,
        );

  KAppBooterState copyWith({AppBooterStatus? status}) {
    return KAppBooterState(
      status: status ?? this.status,
    );
  }
}

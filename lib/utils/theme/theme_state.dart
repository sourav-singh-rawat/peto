part of 'theme_cubit.dart';

class KThemeState {
  final KThemeType type;

  const KThemeState({
    required this.type,
  });

  KThemeState.init()
      : this(
          type: KThemeBox.instance.type,
        );

  KThemeState copyWith({KThemeType? type}) {
    return KThemeState(
      type: type ?? this.type,
    );
  }
}

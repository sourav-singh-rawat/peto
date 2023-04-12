part of 'theme_cubit.dart';

class _KThemeState {
  final KThemeType type;

  _KThemeState({
    required this.type,
  });

  _KThemeState.init()
      : this(
          type: KThemeBox.instance.type,
        );

  _KThemeState copyWith({KThemeType? type}) {
    return _KThemeState(
      type: type ?? this.type,
    );
  }
}

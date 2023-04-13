import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peto/modules/domain/theme/theme.dart';

part 'theme_state.dart';

class KThemeCubit extends Cubit<KThemeState> {
  KThemeCubit() : super(KThemeState.init());

  KThemeBox get current => KThemeBox.instance;

  void switchTo(KThemeType type) {
    KThemeBox.instance.switchTo(type);

    emit(state.copyWith(
      type: type,
    ));
  }

  void toggleTheme() {
    final newType = state.type == KThemeType.dark ? KThemeType.light : KThemeType.dark;

    KThemeBox.instance.switchTo(newType);

    emit(state.copyWith(
      type: newType,
    ));
  }
}

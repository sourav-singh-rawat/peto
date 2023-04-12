import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peto/modules/domain/theme/theme.dart';

part 'theme_state.dart';

class KThemeCubit extends Cubit<_KThemeState> {
  KThemeCubit() : super(_KThemeState.init());

  KThemeBox get current => KThemeBox.instance;

  void switchTo(KThemeType type) {
    emit(state.copyWith(
      type: type,
    ));

    KThemeBox.instance.switchTo(type);
  }
}

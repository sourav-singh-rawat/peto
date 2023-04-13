import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peto/modules/domain/modules.dart';

part 'app_booter_state.dart';
part 'booter_abstract.dart';

class KAppBooterCubit extends Cubit<KAppBooterState> {
  KAppBooterCubit() : super(KAppBooterState.init());

  void bootUp() async {
    final bootUpProcesses = UnmodifiableListView<Future<dynamic>>([
      KModules.instance.bootUp(),
    ]);
    await Future.wait(bootUpProcesses);

    emit(state.copyWith(
      status: AppBooterStatus.booted,
    ));

    _onBootUp();
  }

  void _onBootUp() async {
    KModules.instance.onBootUp();

    // KAppX.router.replace(KBottomNavigatorRoute());
  }

  void bootDown() {
    KModules.instance.bootDown();
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:peto/modules/domain/modules.dart';

class KModulesImpl implements KModules<void> {
  @override
  Future<void> bootUp() async {
    log('[Module.bootUp]');

    for (final module in KModules.bootUpProcesses) {
      try {
        await module.bootUp().then(
              (value) => module.onBootUp(),
            );
      } catch (err) {
        //
      }
    }
  }

  @override
  void bootDown() {
    log('[Module.bootDown]');

    for (final module in KModules.bootUpProcesses.reversed) {
      try {
        module.bootDown();
      } catch (err) {
        //
      }
    }
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
    log('[Module.onBootUp]');
  }
}

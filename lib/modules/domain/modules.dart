import 'dart:collection';

import 'package:peto/modules/data/modules.dart';
import 'package:peto/modules/domain/auth/auth.dart';
import 'package:peto/modules/domain/theme/theme.dart';
import 'package:peto/utils/booter/app_booter_cubit.dart';

abstract class KModules<T> implements Booter<T> {
  static final KModules instance = KModulesImpl();

  static final bootUpProcesses = UnmodifiableListView([
    KThemeBox.instance,
    KAuth.instance,
  ]);
}

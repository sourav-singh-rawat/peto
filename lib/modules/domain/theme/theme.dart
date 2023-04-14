import 'package:flutter/material.dart';
import 'package:peto/modules/data/theme/theme.dart';
import 'package:peto/modules/domain/modules.dart';

part 'policies/colors.dart';
part 'policies/fonts.dart';

enum KThemeType { dark, light }

abstract class KThemeBox implements KModules<void> {
  static final KThemeBox instance = KThemeBoxImpl();

  KThemeType get type;

  KThemeColors get colors;

  KThemeFontWeights get fontWeight;

  void switchTo(KThemeType type);
}

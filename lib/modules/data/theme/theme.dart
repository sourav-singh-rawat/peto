import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peto/modules/domain/theme/theme.dart';
import 'package:peto/utils/app_extensions.dart';

part 'policies/colors/dark.dart';
part 'policies/colors/light.dart';
part 'policies/fonts.dart';

class KThemeBoxImpl implements KThemeBox {
  KThemeType _currentType = KThemeType.light;
  KThemeColors _currentColorsScheme = KThemeColors.light();

  @override
  Future<void> bootUp() async {
    log('[ThemeBox.bootUp]');

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    final themeName = await KAppX.storage.retrieve(
      key: KThemeBox.storage_key,
      decoder: (themeName) {
        return themeName;
      },
    );

    if (themeName != null) {
      final theme = KThemeType.values.firstWhere((type) => type.name == themeName);

      _currentType = theme;
      _currentColorsScheme = theme == KThemeType.dark ? KThemeColors.dark() : KThemeColors.light();
    } else {
      _currentType = KThemeType.light;
      _currentColorsScheme = KThemeColors.light();
    }
  }

  @override
  void bootDown() {
    log('[ThemeBox.bootDown]');
    // TODO: implement bootDown
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  @override
  KThemeType get type => _currentType;

  @override
  KThemeColors get colors => _currentColorsScheme;

  @override
  KThemeFontWeights get fontWeight => _KThemeFontWeightsImpl();

  void _switchToDarkTheme() {
    _currentType = KThemeType.dark;
    _currentColorsScheme = KThemeColors.dark();
  }

  void _switchToLightTheme() {
    _currentType = KThemeType.light;
    _currentColorsScheme = KThemeColors.light();
  }

  @override
  void switchTo(KThemeType type) async {
    await KAppX.storage.store<String>(
      key: KThemeBox.storage_key,
      data: type.name,
      encoder: (themeName) {
        return themeName;
      },
      overwrite: true,
    );

    type == KThemeType.dark ? _switchToDarkTheme() : _switchToLightTheme();
  }
}

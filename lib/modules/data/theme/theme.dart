import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peto/modules/domain/theme/theme.dart';

part 'policies/colors/dark.dart';
part 'policies/colors/light.dart';

class KThemeBoxImpl implements KThemeBox {
  @override
  void bootDown() {
    log('[ThemeBox.bootDown]');
    // TODO: implement bootDown
  }

  @override
  Future<void> bootUp() async {
    log('[ThemeBox.bootUp]');

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  late KThemeType _currentType;
  late KThemeColors _currentColorsScheme;

  KThemeBoxImpl() {
    _currentType = KThemeType.light;
    _currentColorsScheme = KThemeColors.light();
  }

  @override
  KThemeType get type => _currentType;

  @override
  KThemeColors get colors => _currentColorsScheme;

  void _switchToDarkTheme() {
    _currentType = KThemeType.dark;
    _currentColorsScheme = KThemeColors.dark();
  }

  void _switchToLightTheme() {
    _currentType = KThemeType.light;
    _currentColorsScheme = KThemeColors.light();
  }

  @override
  void switchTo(KThemeType type) {
    type == KThemeType.dark ? _switchToDarkTheme() : _switchToLightTheme();
  }
}

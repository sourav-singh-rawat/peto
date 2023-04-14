part of '../theme.dart';

abstract class KThemeColors {
  factory KThemeColors.dark() => KThemeColorsDarkImpl();

  factory KThemeColors.light() => KThemeColorsLightImpl();

  KMaterialColor get primary;

  KMaterialColor get onPrimary;

  Color get onPrimaryVariant;

  KMaterialColor get secondary;

  KMaterialColor get onSecondary;

  Color get background;

  Color get onBackground;

  Color get backgroundVariant;

  Color get onBackgroundVariant;

  KMaterialColor get success;

  KMaterialColor get onSuccess;

  KMaterialColor get error;

  KMaterialColor get onError;

  KMaterialColor get warning;

  KMaterialColor get onWarning;
}

class KMaterialColor extends ColorSwatch<int> {
  const KMaterialColor(super.primary, super.swatch);

  Color get shade10 => this[10]!;

  Color get shade20 => this[20]!;

  Color get shade30 => this[30]!;

  Color get shade40 => this[40]!;

  Color get shade50 => this[50]!;

  Color get shade60 => this[60]!;

  Color get shade70 => this[70]!;

  Color get shade80 => this[80]!;

  Color get shade90 => this[90]!;

  Color get shade95 => this[95]!;

  Color get shade99 => this[99]!;
}

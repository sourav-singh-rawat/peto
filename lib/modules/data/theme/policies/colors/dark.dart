part of '../../theme.dart';

class KThemeColorsDarkImpl implements KThemeColors {
  static const int _primaryMainValue = 0xFF4BC3EA;
  @override
  KMaterialColor get primary => const KMaterialColor(
        _primaryMainValue,
        <int, Color>{
          10: Color(0xFF2d758c),
          20: Color(0xFF3589a4),
          30: Color(0xFF3c9cbb),
          40: Color(0xFF44b0d3),
          50: Color(_primaryMainValue),
          60: Color(0xFF5dc9ec),
          70: Color(0xFF6fcfee),
          80: Color(0xFF81d5f0),
          90: Color(0xFF93dbf2),
          95: Color(0xFFa5e1f5),
          99: Color(0xFFffffff),
        },
      );

  static const int _onPrimaryMainValue = 0xFFFFFFFF;
  @override
  KMaterialColor get onPrimary => const KMaterialColor(
        _onPrimaryMainValue,
        <int, Color>{
          10: Color(0xFF999999),
          20: Color(0xFFb3b3b3),
          30: Color(0xFFcccccc),
          40: Color(0xFFe6e6e6),
          50: Color(_onPrimaryMainValue),
          60: Color(0xFFffffff),
          70: Color(0xFFffffff),
          80: Color(0xFFffffff),
          90: Color(0xFFffffff),
          95: Color(0xFFffffff),
          99: Color(0xFFffffff),
        },
      );

  @override
  Color get onPrimaryVariant => const Color(0xFF1C1A1A);

  static const int _secondaryMainValue = 0xFFFB5634;
  @override
  KMaterialColor get secondary => const KMaterialColor(
        _secondaryMainValue,
        <int, Color>{
          10: Color(0xFF97341f),
          20: Color(0xFFb03c24),
          30: Color(0xFFc9452a),
          40: Color(0xFFe24d2f),
          50: Color(_secondaryMainValue),
          60: Color(0xFFfb6748),
          70: Color(0xFFfc785d),
          80: Color(0xFFfc8971),
          90: Color(0xFFfd9a85),
          95: Color(0xFFfd9a85),
          99: Color(0xFFfd9a85),
        },
      );

  static const int _onSecondaryMainValue = 0xFFFFFFFF;
  @override
  KMaterialColor get onSecondary => const KMaterialColor(
        _onSecondaryMainValue,
        <int, Color>{
          10: Color(0xFF999999),
          20: Color(0xFFb3b3b3),
          30: Color(0xFFcccccc),
          40: Color(0xFFe6e6e6),
          50: Color(_onSecondaryMainValue),
          60: Color(0xFFffffff),
          70: Color(0xFFffffff),
          80: Color(0xFFffffff),
          90: Color(0xFFffffff),
          95: Color(0xFFffffff),
          99: Color(0xFFffffff),
        },
      );

  @override
  Color get background => const Color(0xFF1f1f1f);

  @override
  Color get onBackground => const Color(0xFFFFFFFF);

  @override
  Color get backgroundVariant => const Color(0xFF000000);

  @override
  Color get onBackgroundVariant => const Color(0xFFcccccc);
  @override
  KMaterialColor get success => throw UnimplementedError();

  @override
  KMaterialColor get onSuccess => throw UnimplementedError();

  @override
  KMaterialColor get error => throw UnimplementedError();

  @override
  KMaterialColor get onError => throw UnimplementedError();

  @override
  KMaterialColor get warning => throw UnimplementedError();

  @override
  KMaterialColor get onWarning => throw UnimplementedError();
}

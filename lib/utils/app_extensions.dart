import 'package:peto/modules/domain/storage/storage.dart';
import 'package:peto/utils/profile/profile_cubit.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

class KAppX {
  KAppX._();

  static KStorage storage = KStorage();

  static KProfileCubit profile = KProfileCubit();

  static KThemeCubit theme = KThemeCubit();
}

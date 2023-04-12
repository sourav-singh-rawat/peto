import 'package:peto/modules/domain/storage/storage.dart';
import 'package:peto/utils/profile/cubit/profile_cubit.dart';

class KAppX {
  KAppX._();

  static KStorage storage = KStorage();

  static KProfileCubit profile = KProfileCubit();
}

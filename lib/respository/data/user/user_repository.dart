import 'package:peto/respository/domain/user/user_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'end_points.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Result<UserDetailsSuccess, UserDetailsFailure>> userDetails() {
    throw UnimplementedError();
  }
}

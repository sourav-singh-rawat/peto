import 'package:peto/respository/data/user/user_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'models/user.dart';
part 'request.dart';
part 'response.dart';

abstract class UserRepository extends Repository {
  factory UserRepository() => UserRepositoryImpl();

  Future<Result<GoogleLoginSuccess, GoogleLoginFailure>> googleLogin();

  Future<Result<GoogleLogoutSuccess, GoogleLogoutFailure>> googleLogout();

  Future<Result<UserDetailsSuccess, UserDetailsFailure>> userDetails({
    required UserDetailsRequest request,
  });

  Future<Result<UpdateUserDetailsSuccess, UpdateUserDetailsFailure>> updateUserDetails({
    required UpdateUserDetailsRequest request,
  });
}

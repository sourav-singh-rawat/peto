part of 'user_repository.dart';

class UserFailure extends RepositoryFailure {
  UserFailure({
    int? statusCode,
    String? message,
    RepositoryFailureReason? reason,
  }) : super(
          statusCode: statusCode,
          message: message,
          reason: reason,
        );
}

class UserSuccess extends RepositorySuccess {
  UserSuccess({
    String? message,
  }) : super(message: message);
}

part of 'pet_repository.dart';

class PetFailure extends RepositoryFailure {
  PetFailure({
    int? statusCode,
    String? message,
    RepositoryFailureReason? reason,
  }) : super(
          statusCode: statusCode,
          message: message,
          reason: reason,
        );
}

class PetSuccess extends RepositorySuccess {
  PetSuccess({
    String? message,
  }) : super(message: message);
}

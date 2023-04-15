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

class PetListSuccess extends PetSuccess {
  final List<PetDetails> pets;

  PetListSuccess({
    required this.pets,
  });
}

class PetListFailure extends PetFailure {
  PetListFailure();
}

class PetAdoptionDetailsSuccess extends PetSuccess {
  final PetAdoptionDetails adoptionDetails;

  PetAdoptionDetailsSuccess({
    required this.adoptionDetails,
  });
}

class PetAdoptionDetailsFailure extends PetFailure {
  PetAdoptionDetailsFailure();
}

class AdoptionSuccess extends PetSuccess {
  AdoptionSuccess();
}

class AdoptionFailure extends PetFailure {
  AdoptionFailure();
}

class AdoptionHistoryDetails {
  final PetAdoptionDetails details;
  final UserDetails? userDetails;
  final PetDetails? petDetails;

  AdoptionHistoryDetails({
    required this.details,
    required this.userDetails,
    required this.petDetails,
  });
}

class AdoptionHistorySuccess extends PetSuccess {
  final List<AdoptionHistoryDetails> adoptionHistoryList;
  AdoptionHistorySuccess({
    required this.adoptionHistoryList,
  });
}

class AdoptionHistoryFailure extends PetFailure {
  AdoptionHistoryFailure();
}

class PetDetailsSuccess extends PetSuccess {
  final PetDetails details;
  PetDetailsSuccess({
    required this.details,
  });
}

class PetDetailsFailure extends PetFailure {
  PetDetailsFailure();
}

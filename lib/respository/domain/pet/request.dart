part of 'pet_repository.dart';

class PetListRequest extends RepositoryRequest {
  PetListRequest();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class PetAdoptionDetailsRequest extends RepositoryRequest {
  final String pid;
  PetAdoptionDetailsRequest({
    required this.pid,
  });

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class AdoptionRequest extends RepositoryRequest {
  final String pid;
  final PetAdoptionDetails adoptionDetails;
  AdoptionRequest({
    required this.pid,
    required this.adoptionDetails,
  });

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class AdoptionHistoryRequest extends RepositoryRequest {
  AdoptionHistoryRequest();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class PetDetailsRequest extends RepositoryRequest {
  final String pid;
  PetDetailsRequest({required this.pid});

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

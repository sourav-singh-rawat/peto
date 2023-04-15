import 'package:peto/respository/data/pet/pet_repository.dart';
import 'package:peto/respository/domain/user/user_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'models/pet.dart';
part 'request.dart';
part 'response.dart';
part 'models/adoption_details.dart';

abstract class PetRepository extends Repository {
  factory PetRepository() => PetRepositoryImpl();

  Future<Result<PetListSuccess, PetListFailure>> petsList({required PetListRequest request});
  Future<Result<PetDetailsSuccess, PetDetailsFailure>> petDetails({required PetDetailsRequest request});
  Future<Result<PetAdoptionDetailsSuccess, PetAdoptionDetailsFailure>> petAdoptionDetails({required PetAdoptionDetailsRequest request});
  Future<Result<AdoptionSuccess, AdoptionFailure>> adoptPet({required AdoptionRequest request});
  Future<Result<AdoptionHistorySuccess, AdoptionHistoryFailure>> adoptionHistory({required AdoptionHistoryRequest request});
}

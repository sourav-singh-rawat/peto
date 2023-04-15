import 'package:peto/respository/data/pet/pet_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'models/pet.dart';
part 'request.dart';
part 'response.dart';

abstract class PetRepository extends Repository {
  factory PetRepository() => PetRepositoryImpl();

  Future<Result<PetListSuccess, PetListFailure>> petsList({required PetListRequest request});
}

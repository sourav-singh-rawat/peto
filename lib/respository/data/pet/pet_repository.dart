import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'end_points.dart';

final _firestore = FirebaseFirestore.instance;

class PetRepositoryImpl implements PetRepository {
  //static b/c single instance required
  static DocumentSnapshot? _lastPetDocumentSnapped;
  @override
  Future<Result<PetListSuccess, PetListFailure>> petsList() async {
    try {
      late Query<Map<String, dynamic>> query;

      if (_lastPetDocumentSnapped != null) {
        query =
            _firestore.collection('pets').startAfterDocument(_lastPetDocumentSnapped!).limit(10);
      } else {
        query = _firestore.collection('pets').limit(10);
      }

      final collection = await query.get();

      final documents = collection.docs;

      _lastPetDocumentSnapped = documents.last;

      final pets = documents.map<PetDetails>((doc) {
        return PetDetails.fromJson(pid: doc.id, json: doc.data());
      }).toList();

      return Success(PetListSuccess(pets: pets));
    } on StateError {
      return Success(PetListSuccess(pets: []));
    } catch (error) {
      return Failure(PetListFailure());
    }
  }
}

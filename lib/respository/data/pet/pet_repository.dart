import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'end_points.dart';

final _firestore = FirebaseFirestore.instance;

class PetRepositoryImpl implements PetRepository {
  //static b/c single instance required
  static DocumentSnapshot? _lastPetDocumentSnapped;
  @override
  Future<Result<PetListSuccess, PetListFailure>> petsList({required PetListRequest request}) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection('pets');

      if (request.queryValue != null && request.queryValue!.isNotEmpty) {
        query = query.where('name', isGreaterThan: request.queryValue!).where('name', isLessThan: request.queryValue!).orderBy('name');
        // .where('type', isGreaterThanOrEqualTo: request.queryValue!)
        // .where('type', isLessThan: '${request.queryValue!}\uf7ff')
        // .where('breed', isGreaterThanOrEqualTo: request.queryValue!)
        // .where('breed', isLessThan: '${request.queryValue!}\uf7ff')
        // .where('location', isGreaterThanOrEqualTo: request.queryValue!)
        // .where('location', isLessThan: '${request.queryValue!}\uf7ff');
      }

      if (request.queryOptionsSelected != null) {
        for (final entry in request.queryOptionsSelected!.entries) {
          for (final value in entry.value) {
            query = query.where(entry.key, isEqualTo: value);
          }
        }
      }

      query = query.limit(10);

      if (_lastPetDocumentSnapped != null) {
        query = query.startAfterDocument(_lastPetDocumentSnapped!);
      }

      final collection = await query.get();

      final documents = collection.docs;

      if (documents.isNotEmpty) {
        _lastPetDocumentSnapped = documents.last;
      }

      final pets = documents.map<PetDetails>((doc) {
        return PetDetails.fromJson(pid: doc.id, json: doc.data());
      }).toList();

      return Success(PetListSuccess(pets: pets));
    } catch (error) {
      return Failure(PetListFailure());
    }
  }
}

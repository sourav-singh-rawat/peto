import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'end_points.dart';

final _firestore = FirebaseFirestore.instance;

class PetRepositoryImpl implements PetRepository {
  @override
  Future<Result<PetListSuccess, PetListFailure>> petsList() async {
    try {
      final collection = await _firestore.collection('pets').get();

      final documents = collection.docs;

      final pets = documents.map<PetDetails>((doc) {
        return PetDetails.fromJson(pid: doc.id, json: doc.data());
      }).toList();

      return Success(PetListSuccess(pets: pets));
    } catch (error) {
      log(error.toString());
      return Failure(PetListFailure());
    }
  }
}

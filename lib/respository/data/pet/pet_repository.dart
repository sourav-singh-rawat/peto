import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/respository/domain/user/user_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'end_points.dart';

final _firestore = FirebaseFirestore.instance;

class PetRepositoryImpl implements PetRepository {
  //static b/c single instance required
  static DocumentSnapshot? _lastPetDocumentSnapped;
  @override
  Future<Result<PetListSuccess, PetListFailure>> petsList({required PetListRequest request}) async {
    try {
      var query = _firestore.collection('pets').limit(10);

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

      if (_lastPetDocumentSnapped != null) {
        query = query.startAfterDocument(_lastPetDocumentSnapped!);
      }

      final collection = await query.get();

      final documents = collection.docs;

      if (documents.isNotEmpty) {
        _lastPetDocumentSnapped = documents.last;
      }

      List<PetDetails> pets = [];

      final petRepository = PetRepository();

      await Future.forEach(documents, (doc) async {
        final completer = Completer<PetAdoptionDetails?>();

        final adoptionDetailsResponse = await petRepository.petAdoptionDetails(
          request: PetAdoptionDetailsRequest(
            pid: doc.id,
          ),
        );

        void onAdoptionDetailsSuccess(PetAdoptionDetailsSuccess success) {
          completer.complete(success.adoptionDetails);
        }

        void onAdoptionDetailsFailure(PetAdoptionDetailsFailure failure) {
          completer.complete();
        }

        adoptionDetailsResponse.resolve(onAdoptionDetailsSuccess, onAdoptionDetailsFailure);

        final adoptionDetails = await completer.future;

        pets.add(
          PetDetails.fromJson(
            pid: doc.id,
            json: doc.data(),
            adoptionDetails: adoptionDetails,
          ),
        );
      });

      return Success(PetListSuccess(pets: pets));
    } catch (error) {
      return Failure(PetListFailure());
    }
  }

  @override
  Future<Result<PetDetailsSuccess, PetDetailsFailure>> petDetails({
    required PetDetailsRequest request,
  }) async {
    try {
      final query = _firestore.collection('adoption_status').doc(request.pid);

      final document = await query.get();

      if (!document.exists) {
        return Failure(PetDetailsFailure());
      }

      final data = document.data();

      if (data != null) {
        final petRepository = PetRepository();

        final completer = Completer<PetAdoptionDetails?>();

        final petDetailsResponse = await petRepository.petAdoptionDetails(request: PetAdoptionDetailsRequest(pid: request.pid));

        void onPetAdoptionDetailsSuccess(PetAdoptionDetailsSuccess success) {
          completer.complete(success.adoptionDetails);
        }

        void onPetAdoptionDetailsFailure(PetAdoptionDetailsFailure failure) {
          completer.complete();
        }

        petDetailsResponse.resolve(onPetAdoptionDetailsSuccess, onPetAdoptionDetailsFailure);

        final petAdoptionDetails = await completer.future;

        return Success(
          PetDetailsSuccess(
            details: PetDetails.fromJson(
              pid: request.pid,
              json: data,
              adoptionDetails: petAdoptionDetails,
            ),
          ),
        );
      } else {
        return Failure(PetDetailsFailure());
      }
    } catch (error) {
      return Failure(PetDetailsFailure());
    }
  }

  @override
  Future<Result<PetAdoptionDetailsSuccess, PetAdoptionDetailsFailure>> petAdoptionDetails({
    required PetAdoptionDetailsRequest request,
  }) async {
    try {
      final query = _firestore.collection('adoption_status').doc(request.pid);

      final document = await query.get();

      if (!document.exists) {
        return Failure(PetAdoptionDetailsFailure());
      }

      final data = document.data();

      if (data != null) {
        return Success(
          PetAdoptionDetailsSuccess(
            adoptionDetails: PetAdoptionDetails.fromJson(data),
          ),
        );
      } else {
        return Failure(PetAdoptionDetailsFailure());
      }
    } catch (error) {
      return Failure(PetAdoptionDetailsFailure());
    }
  }

  @override
  Future<Result<AdoptionSuccess, AdoptionFailure>> adoptPet({
    required AdoptionRequest request,
  }) async {
    try {
      final query = _firestore.collection('adoption_status').doc(request.pid);

      await query.set(request.adoptionDetails.toRequestJson());

      return Success(AdoptionSuccess());
    } catch (error) {
      return Failure(AdoptionFailure());
    }
  }

  @override
  Future<Result<AdoptionHistorySuccess, AdoptionHistoryFailure>> adoptionHistory({
    required AdoptionHistoryRequest request,
  }) async {
    try {
      var query = _firestore.collection('adoption_status');

      final collection = await query.get();

      final documents = collection.docs;

      List<AdoptionHistoryDetails> adoptionHistoryDetails = [];

      final petRepository = PetRepository();

      await Future.forEach(documents, (doc) async {
        final data = doc.data();

        final adoptionDetails = PetAdoptionDetails.fromJson(data);

        final completer = Completer<PetDetails?>();

        final petDetailsResponse = await petRepository.petDetails(
          request: PetDetailsRequest(
            pid: doc.id,
          ),
        );

        void onPetDetailsSuccess(PetDetailsSuccess success) {
          completer.complete(success.details);
        }

        void onPetDetailsFailure(PetDetailsFailure failure) {
          completer.complete();
        }

        petDetailsResponse.resolve(onPetDetailsSuccess, onPetDetailsFailure);

        final petDetails = await completer.future;

        final userRepository = UserRepository();

        UserDetails? userDetails;

        final adopterId = adoptionDetails.uid;

        if (adopterId != null) {
          final completer = Completer<UserDetails?>();

          final userDetailsResponse = await userRepository.userDetails(
            request: UserDetailsRequest(uid: adopterId),
          );

          void onUserDetailsSuccess(UserDetailsSuccess success) {
            completer.complete(success.userDetails);
          }

          void onUserDetailsFailure(UserDetailsFailure failure) {
            completer.complete();
          }

          userDetailsResponse.resolve(onUserDetailsSuccess, onUserDetailsFailure);

          userDetails = await completer.future;
        }

        adoptionHistoryDetails.add(
          AdoptionHistoryDetails(
            details: adoptionDetails,
            userDetails: userDetails,
            petDetails: petDetails,
          ),
        );
      });

      return Success(
        AdoptionHistorySuccess(
          adoptionHistoryList: adoptionHistoryDetails,
        ),
      );
    } catch (error) {
      return Failure(AdoptionHistoryFailure());
    }
  }
}

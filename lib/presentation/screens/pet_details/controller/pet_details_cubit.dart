part of '../view.dart';

class _PetDetailsCubit extends Cubit<_PetDetailsState> with KEventListener {
  _PetDetailsCubit() : super(_PetDetailsState.init());

  final scrollController = ScrollController();

  final petRepository = PetRepository();

  void initState({required String pid, required BuildContext context}) async {
    fetchPetDetails(pid);

    scrollController.addListener(() {
      if (scrollController.position.pixels >= MediaQuery.of(context).padding.top) {
        emit(state.copyWith(
          isScrolledToTop: true,
        ));
      } else {
        emit(state.copyWith(
          isScrolledToTop: false,
        ));
      }
    });

    KAppX.eventBroker.addListener(this);
  }

  void fetchPetDetails(String pid) async {
    final petDetailsResponse = await petRepository.petDetails(
      request: PetDetailsRequest(
        pid: pid,
      ),
    );

    void onSuccess(PetDetailsSuccess success) {
      emit(state.copyWith(
        petDetails: success.details,
        petDetailsStatus: ApiStatus.success,
      ));
    }

    void onFailure(PetDetailsFailure failure) {
      emit(state.copyWith(
        petDetailsStatus: ApiStatus.failed,
      ));
    }

    petDetailsResponse.resolve(onSuccess, onFailure);
  }

  Future<void> onAdoptMePressed(PetDetails petDetails) async {
    final adoptionDetails = petDetails.adoptionDetails;
    if (adoptionDetails != null) {
      emit(state.copyWith(
        isAdopting: true,
      ));

      final completer = Completer();

      final response = await petRepository.adoptPet(
        request: AdoptionRequest(
          pid: petDetails.pid,
          adoptionDetails: adoptionDetails,
        ),
      );

      void onSuccess(AdoptionSuccess success) {
        emit(state.copyWith(
          isAdopting: false,
        ));

        KAppX.eventBroker.emitEvent(NewPetAdopted());

        completer.complete();
      }

      void onFailure(AdoptionFailure failure) {
        emit(state.copyWith(
          isAdopting: false,
        ));

        completer.complete();
      }

      response.resolve(onSuccess, onFailure);

      return await completer.future;
    }
  }

  @override
  void onEvent(KEvent event) {
    if (event is NewPetAdopted) {
      fetchPetDetails(state.petDetails!.pid);
    }
  }
}

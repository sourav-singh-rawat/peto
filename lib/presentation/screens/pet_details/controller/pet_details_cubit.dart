part of '../view.dart';

class _PetDetailsCubit extends Cubit<_PetDetailsState> {
  _PetDetailsCubit() : super(_PetDetailsState.init());

  final scrollController = ScrollController();

  void initState(BuildContext context) {
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
  }

  Future<void> onAdoptMePressed(PetDetails petDetails) async {
    final adoptionDetails = petDetails.adoptionDetails;
    if (adoptionDetails != null) {
      emit(state.copyWith(
        isAdopting: true,
      ));

      final completer = Completer();

      final petRepository = PetRepository();

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
}

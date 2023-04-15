part of '../../../view.dart';

class _PetListCubit extends Cubit<_PetListState> {
  _PetListCubit() : super(_PetListState.init());

  final petRepository = PetRepository();

  final scrollController = ScrollController();

  final throttle = KThrottle(duration: const Duration(milliseconds: 5000));

  void initState() {
    fetchPetList();

    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(KAppX.currentContext!).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        emit(state.copyWith(
          petListStatus: ApiStatus.loading,
        ));

        throttle(() {
          Future.delayed(const Duration(milliseconds: 2000), fetchPetList);
        });
      }
    });
  }

  void fetchPetList({
    PetListRequest? request,
    bool isSearching = false,
  }) async {
    if (isSearching) {
      emit(state.copyWith(
        pets: [],
        petListStatus: ApiStatus.loading,
      ));
      return;
    }

    final response = await petRepository.petsList(
      request: PetListRequest().copyWith(
        queryValue: request?.queryValue,
        queryOptionsSelected: request?.queryOptionsSelected,
      ),
    );

    void onSuccess(PetListSuccess success) {
      if (isSearching) {
        emit(
          state.copyWith(
            petListStatus: ApiStatus.success,
            pets: success.pets,
          ),
        );
      } else {
        emit(state.copyWith(
          petListStatus: ApiStatus.success,
          pets: [...state.pets, ...success.pets],
        ));
      }
    }

    void onFailure(PetListFailure failure) {
      emit(state.copyWith(
        petListStatus: ApiStatus.failed,
        pets: state.pets,
      ));
    }

    response.resolve(onSuccess, onFailure);
  }

  void onPetTilePressed(PetDetails petDetails) {
    KAppX.router.push(
      path: '/pet_details',
      page: PetDetailsView(
        petDetails: petDetails,
      ),
      fullScreenDialog: true,
    );
  }
}

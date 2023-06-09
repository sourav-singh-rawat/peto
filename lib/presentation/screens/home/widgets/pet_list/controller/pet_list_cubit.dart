part of '../../../view.dart';

class _PetListCubit extends Cubit<_PetListState> with KEventListener {
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

        throttle(fetchPetList);
      }
    });

    KAppX.eventBroker.addListener(this);
  }

  List<PetDetails> _catchPetList = [];

  void fetchPetList({bool isForceFetch = false}) async {
    final response = await petRepository.petsList(request: PetListRequest());

    void onSuccess(PetListSuccess success) {
      if (isForceFetch) {
        emit(state.copyWith(
          petListStatus: ApiStatus.success,
          pets: state.pets,
        ));
      } else {
        emit(state.copyWith(
          petListStatus: ApiStatus.success,
          pets: [...state.pets, ...success.pets],
        ));
      }

      _catchPetList = state.pets;
    }

    void onFailure(PetListFailure failure) {
      emit(state.copyWith(
        petListStatus: ApiStatus.failed,
        pets: state.pets,
      ));

      _catchPetList = state.pets;
    }

    response.resolve(onSuccess, onFailure);
  }

  void onPetTilePressed(PetDetails petDetails) {
    KAppX.router.push(
      path: '/pet_details',
      page: PetDetailsView(
        pid: petDetails.pid,
        name: petDetails.name,
        imageUrl: petDetails.imageUrl?[0],
      ),
      fullScreenDialog: true,
    );
  }

  void searchInPetList(String searchString) {
    final _searchString = searchString.toLowerCase();
    final sortedList = state.pets
        .where(
          (pet) =>
              (pet.name?.toLowerCase().startsWith(_searchString) ?? false) ||
              (pet.type?.name.toLowerCase().startsWith(_searchString) ?? false) ||
              (pet.breed?.toLowerCase().startsWith(_searchString) ?? false) ||
              (pet.location?.toLowerCase().startsWith(_searchString) ?? false) ||
              (pet.gender?.name.toLowerCase().startsWith(_searchString) ?? false),
        )
        .toList();

    emit(state.copyWith(
      pets: sortedList,
    ));
  }

  void resetSearch() {
    emit(state.copyWith(
      pets: _catchPetList,
    ));
  }

  void filterPetList(List<Enum> filters) {
    var pets = [...state.pets];
    for (final item in filters) {
      pets = pets.where((pet) => (pet.type?.name == item.name) || (pet.gender?.name == item.name)).toList();
    }

    emit(state.copyWith(
      pets: pets,
    ));
  }

  @override
  void onEvent(KEvent event) {
    if (event is NewPetAdopted) {
      fetchPetList(isForceFetch: true);
    }
  }
}

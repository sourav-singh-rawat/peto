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

  void fetchPetList() async {
    final response = await petRepository.petsList();

    void onSuccess(PetListSuccess success) {
      emit(state.copyWith(
        petListStatus: ApiStatus.success,
        pets: [...state.pets, ...success.pets],
      ));
    }

    void onFailure(PetListFailure failure) {
      emit(state.copyWith(
        petListStatus: ApiStatus.failed,
        pets: state.pets,
      ));
    }

    response.resolve(onSuccess, onFailure);
  }
}

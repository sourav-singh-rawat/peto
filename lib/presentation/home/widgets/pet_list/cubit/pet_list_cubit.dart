part of '../../../view.dart';

class _PetListCubit extends Cubit<_PetListState> {
  _PetListCubit() : super(_PetListState.init());

  final petRepository = PetRepository();

  void fetchPetList() async {
    final response = await petRepository.petsList();

    void onSuccess(PetListSuccess success) {
      emit(state.copyWith(
        petListStatus: ApiStatus.success,
        pets: success.pets,
      ));
    }

    void onFailure(PetListFailure failure) {
      emit(state.copyWith(
        petListStatus: ApiStatus.failed,
      ));
    }

    response.resolve(onSuccess, onFailure);
  }
}

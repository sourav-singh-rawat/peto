part of '../../../view.dart';

class _PetListState {
  final ApiStatus petListStatus;
  final List<PetDetails> pets;
  _PetListState({
    required this.petListStatus,
    required this.pets,
  });

  _PetListState.init()
      : this(
          petListStatus: ApiStatus.loading,
          pets: [],
        );

  _PetListState copyWith({
    ApiStatus? petListStatus,
    List<PetDetails>? pets,
  }) {
    return _PetListState(
      petListStatus: petListStatus ?? this.petListStatus,
      pets: pets ?? this.pets,
    );
  }
}

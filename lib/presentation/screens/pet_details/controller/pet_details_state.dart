part of '../view.dart';

class _PetDetailsState {
  final bool isAdopting;
  final bool isScrolledToTop;
  final PetDetails? petDetails;
  final ApiStatus petDetailsStatus;
  _PetDetailsState({
    required this.isAdopting,
    required this.isScrolledToTop,
    this.petDetails,
    required this.petDetailsStatus,
  });

  _PetDetailsState.init()
      : this(
          isAdopting: false,
          isScrolledToTop: false,
          petDetailsStatus: ApiStatus.loading,
        );

  _PetDetailsState copyWith({
    bool? isAdopting,
    bool? isScrolledToTop,
    PetDetails? petDetails,
    ApiStatus? petDetailsStatus,
  }) {
    return _PetDetailsState(
      isAdopting: isAdopting ?? this.isAdopting,
      isScrolledToTop: isScrolledToTop ?? this.isScrolledToTop,
      petDetails: petDetails ?? this.petDetails,
      petDetailsStatus: petDetailsStatus ?? this.petDetailsStatus,
    );
  }
}

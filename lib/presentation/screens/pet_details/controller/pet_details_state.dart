part of '../view.dart';

class _PetDetailsState {
  final bool isAdopting;
  final bool isScrolledToTop;
  _PetDetailsState({
    required this.isAdopting,
    required this.isScrolledToTop,
  });

  _PetDetailsState.init()
      : this(
          isAdopting: false,
          isScrolledToTop: false,
        );

  _PetDetailsState copyWith({
    bool? isAdopting,
    bool? isScrolledToTop,
  }) {
    return _PetDetailsState(
      isAdopting: isAdopting ?? this.isAdopting,
      isScrolledToTop: isScrolledToTop ?? this.isScrolledToTop,
    );
  }
}

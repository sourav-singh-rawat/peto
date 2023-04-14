part of '../../../view.dart';

class _PetImageState {
  final int currentIndex;
  _PetImageState({
    required this.currentIndex,
  });

  _PetImageState.init()
      : this(
          currentIndex: 0,
        );

  _PetImageState copyWith({
    int? currentIndex,
  }) {
    return _PetImageState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

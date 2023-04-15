part of '../view.dart';

class _HomeState {
  final bool isSearching;
  _HomeState({
    required this.isSearching,
  });

  _HomeState.init() : this(isSearching: false);

  _HomeState copyWith({
    bool? isSearching,
    PetListRequest? petListRequest,
  }) {
    return _HomeState(
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

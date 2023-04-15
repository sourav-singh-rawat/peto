part of '../view.dart';

class _HomeState {
  final bool isSearching;
  final List<Enum> filters;
  _HomeState({
    required this.isSearching,
    required this.filters,
  });

  _HomeState.init()
      : this(
          isSearching: false,
          filters: [],
        );

  _HomeState copyWith({
    bool? isSearching,
    List<Enum>? filters,
  }) {
    return _HomeState(
      isSearching: isSearching ?? this.isSearching,
      filters: filters ?? this.filters,
    );
  }
}

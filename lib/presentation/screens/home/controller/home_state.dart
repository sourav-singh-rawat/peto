part of '../view.dart';

class _HomeState {
  final bool isLoggingOut;
  final bool isSearching;
  final List<Enum> filters;
  _HomeState({
    required this.isSearching,
    required this.filters,
    required this.isLoggingOut,
  });

  _HomeState.init()
      : this(
          isSearching: false,
          filters: [],
          isLoggingOut: false,
        );

  _HomeState copyWith({
    bool? isSearching,
    List<Enum>? filters,
    bool? isLoggingOut,
  }) {
    return _HomeState(
      isSearching: isSearching ?? this.isSearching,
      filters: filters ?? this.filters,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
    );
  }
}

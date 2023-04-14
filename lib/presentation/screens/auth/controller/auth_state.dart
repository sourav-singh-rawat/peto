part of '../view.dart';

class _AuthState {
  final bool isAuthenticating;
  _AuthState({
    required this.isAuthenticating,
  });

  _AuthState.init() : this(isAuthenticating: false);

  _AuthState copyWith({
    bool? isAuthenticating,
  }) {
    return _AuthState(
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
    );
  }
}

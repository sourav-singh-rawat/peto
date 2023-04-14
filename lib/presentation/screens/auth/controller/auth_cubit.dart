part of '../view.dart';

class _AuthCubit extends Cubit<_AuthState> {
  _AuthCubit() : super(_AuthState.init());

  final userRepository = UserRepository();

  void onGoogleLoginPressed() async {
    HapticFeedback.mediumImpact();

    final response = await userRepository.googleLogin();

    void onSuccess(GoogleLoginSuccess success) {
      emit(state.copyWith(
        isAuthenticating: false,
      ));
    }

    void onFailure(GoogleLoginFailure failure) {
      emit(state.copyWith(
        isAuthenticating: false,
      ));
    }

    response.resolve(onSuccess, onFailure);
  }
}

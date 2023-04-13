import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:peto/modules/domain/auth/auth.dart';
import 'package:peto/respository/domain/user/user_repository.dart';

part 'profile_state.dart';

class KProfileCubit extends Cubit<KProfileState> {
  KProfileCubit() : super(KProfileState.init());

  Future<bool> refresh() async {
    final completer = Completer<bool>();

    final isUserAuthenticated = KAuth.instance.authStatus == AuthStatus.authenticated;

    Future<void> onSuccess(UserDetailsSuccess success) async {
      emit(KProfileState(
        userDetails: success.userDetails,
      ));

      completer.complete(true);
    }

    Future<void> onFailure(UserDetailsFailure failure) async {
      emit(KProfileState(
        userDetails: null,
      ));

      completer.complete(false);
    }

    if (isUserAuthenticated) {
      final userRepository = UserRepository();

      final response = await userRepository.userDetails();

      response.resolve(onSuccess, onFailure);
    } else {
      onFailure(UserDetailsFailure());
    }

    return completer.future;
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:peto/modules/domain/auth/auth.dart';
import 'package:peto/utils/app_extensions.dart';

class KAuthImpl implements KAuth {
  AuthStatus _authStatus = AuthStatus.unauthenticated;

  @override
  Future<void> bootUp() async {
    log('[Auth.bootUp]');

    _authStatus = AuthStatus.unauthenticated;

    final token = await KAppX.storage.retrieve(
      key: KAuth.authenticationTokenKey,
      decoder: (token) {
        return token;
      },
    );

    if (token != null) {
      _authStatus = AuthStatus.authenticated;

      await KAppX.profile.refresh();
    }
  }

  @override
  void bootDown() {
    log('[Auth.onBootDown]');
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  @override
  AuthStatus get authStatus => _authStatus;

  @override
  Future<void> onLogIn(String token) async {
    await KAppX.storage.store<String>(
      key: KAuth.authenticationTokenKey,
      data: token,
      encoder: (token) {
        return token;
      },
      overwrite: true,
    );

    _authStatus = AuthStatus.authenticated;
  }

  @override
  Future<void> onLogOut() async {
    await KAppX.storage.delete(
      key: KAuth.authenticationTokenKey,
    );

    _authStatus = AuthStatus.unauthenticated;

    await KAppX.profile.refresh();
  }
}

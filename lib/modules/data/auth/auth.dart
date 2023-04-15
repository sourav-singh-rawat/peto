import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:peto/modules/domain/auth/auth.dart';
import 'package:peto/utils/app_extensions.dart';

class KAuthImpl implements KAuth {
  AuthStatus _authStatus = AuthStatus.unauthenticated;

  final StreamController<AuthStatus> _authStatusStreamSubscription = StreamController<AuthStatus>();

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

      await KAppX.profile.refresh(token);
    }

    notifyAuthStatus();
  }

  @override
  void bootDown() {
    log('[Auth.onBootDown]');
  }

  @override
  void onBootUp() {}

  @override
  AuthStatus get authStatus => _authStatus;

  @override
  Stream<AuthStatus> get autStatusListener => _authStatusStreamSubscription.stream;

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

    notifyAuthStatus();
  }

  @override
  Future<void> onLogOut() async {
    await KAppX.storage.delete(
      key: KAuth.authenticationTokenKey,
    );

    _authStatus = AuthStatus.unauthenticated;

    await KAppX.profile.refresh();

    notifyAuthStatus();
  }

  void notifyAuthStatus() async {
    _authStatusStreamSubscription.add(_authStatus);
  }
}

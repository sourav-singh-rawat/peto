import 'package:peto/modules/data/auth/auth.dart';
import 'package:peto/modules/domain/modules.dart';

enum AuthStatus { authenticated, unauthenticated }

typedef OnAuthStatusChanged = void Function(AuthStatus authStatus);

abstract class KAuth implements KModules<void> {
  static final KAuth instance = KAuthImpl();

  static const String authenticationTokenKey = 'authentication_token';

  Stream<AuthStatus> get autStatusListener;

  AuthStatus get authStatus;

  Future<void> onLogIn(String token);

  Future<void> onLogOut();
}

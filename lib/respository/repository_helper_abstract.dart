///ApiStatus: To update UI/View according to status of api called from controller
///init: on controller class/variable is initialized
///loading: on api is called
///success: on api response is success
///failed: on api response is failure
enum ApiStatus { init, loading, success, failed }

///----Repository Abstracts----------
abstract class RepositoryRequest {
  const RepositoryRequest();
  Map<String, dynamic> toJson();
}

abstract class RepositorySuccess {
  String? message;

  RepositorySuccess({
    this.message,
  }) {
    message ??= 'Success';
  }
}

enum RepositoryFailureReason {
  unknown,
  invalidRequest,
}

abstract class RepositoryFailure {
  String? message;
  final int? statusCode;
  RepositoryFailureReason? reason;

  RepositoryFailure({
    this.statusCode,
    this.message,
    this.reason,
  }) {
    message ??= 'Oops! Something went wrong.';
    reason ??= RepositoryFailureReason.unknown;
  }
}

abstract class Repository {}

///------Responses Abstracts------

Result<S, F> success<S, F>(S s) => Success<S, F>(s);
Result<S, F> failure<S, F>(F f) => Failure<S, F>(f);

// Any repository or API call can return this type.
abstract class Result<S, F> {
  const Result();

  bool isSuccess() {
    return resolve<bool>((_) => true, (_) => false);
  }

  bool isFailure() {
    return resolve<bool>((_) => false, (_) => true);
  }

  // Benefit here is that `Success` comes before `Failure`. Optimistic!
  B resolve<B>(B Function(S s) onSuccess, B Function(F f) onFailure);
}

class Failure<S, F> extends Result<S, F> {
  final F _f;

  const Failure(this._f);

  F get value => _f;

  @override
  B resolve<B>(B Function(S s) onSuccess, B Function(F f) onFailure) => onFailure(_f);

  @override
  bool operator ==(other) => other is Failure && other._f == _f;

  @override
  int get hashCode => _f.hashCode;
}

class Success<S, F> extends Result<S, F> {
  final S _s;

  const Success(this._s);

  S get value => _s;

  @override
  B resolve<B>(B Function(S s) onSuccess, B Function(F f) onFailure) => onSuccess(_s);

  @override
  bool operator ==(other) => other is Success && other._s == _s;

  @override
  int get hashCode => _s.hashCode;
}

///------Helper Extensions-----

extension IntRepositoryX on int? {
  bool get isSuccess {
    if (this != null) {
      return this! >= 200 && this! <= 299;
    } else {
      return false;
    }
  }

  bool get is404 {
    if (this != null) {
      return this! == 404;
    } else {
      return false;
    }
  }
}

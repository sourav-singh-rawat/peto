part of 'profile_cubit.dart';

class KProfileState {
  final UserDetails? userDetails;

  KProfileState({
    required this.userDetails,
  });

  KProfileState.init()
      : this(
          userDetails: null,
        );
}

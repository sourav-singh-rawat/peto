part of 'user_repository.dart';

class UserDetailsRequest extends RepositoryRequest {
  final String uid;
  UserDetailsRequest({required this.uid});

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class UpdateUserDetailsRequest extends RepositoryRequest {
  final UserDetails userDetails;
  UpdateUserDetailsRequest({
    required this.userDetails,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "uid": userDetails.uid,
      "name": userDetails.name,
      "email": userDetails.email,
      "phoneNumber": userDetails.phoneNumber,
      "photoUrl": userDetails.photoUrl
    };
  }
}

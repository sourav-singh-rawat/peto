part of '../user_repository.dart';

class UserDetails {
  final String uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;

  UserDetails({
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.photoUrl,
  });

  UserDetails.fromJson(Map<String, dynamic> json)
      : this(
          uid: json['uid'],
          name: json['name'],
          email: json['breed'],
          phoneNumber: json['age'],
          photoUrl: json['photoUrl'],
        );
}

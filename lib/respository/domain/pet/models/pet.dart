part of '../pet_repository.dart';

class PetDetails {
  final String pid;
  final String? name;
  final PetType? type;
  final String? breed;
  final int? age;
  final PetGender? gender;
  final String? location;
  final String? description;
  final List<String>? imageUrl;
  final PetAdoptionDetails? adoptionDetails;

  PetDetails({
    required this.pid,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.gender,
    required this.location,
    required this.description,
    required this.imageUrl,
    this.adoptionDetails,
  });

  PetDetails.fromJson({
    required String pid,
    required Map<String, dynamic> json,
    required PetAdoptionDetails? adoptionDetails,
  }) : this(
          pid: pid,
          name: json['name'],
          type: (json['type'] as String?).toPetType,
          breed: json['breed'],
          age: json['age'],
          gender: (json['gender'] as String?).toPetGender,
          location: json['location'],
          description: json['description'],
          imageUrl: json['image_url'].cast<String>(),
          adoptionDetails: adoptionDetails,
        );

  PetDetails copyWith({PetAdoptionDetails? adoptionDetails}) {
    return PetDetails(
      pid: pid,
      name: name,
      type: type,
      breed: breed,
      age: age,
      gender: gender,
      location: location,
      description: description,
      imageUrl: imageUrl,
      adoptionDetails: adoptionDetails ?? this.adoptionDetails,
    );
  }
}

enum PetType { dog, cat }

enum PetGender { male, female }

extension on String? {
  PetType? get toPetType {
    final type = this?.toLowerCase();

    return PetType.values.firstWhere((element) => element.name == type);
  }

  PetGender? get toPetGender {
    final gender = this?.toLowerCase();

    return PetGender.values.firstWhere((element) => element.name == gender);
  }
}

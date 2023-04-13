part of '../pet_repository.dart';

class PetDetails {
  final String pid;
  final String name;
  final String type;
  final String breed;
  final int age;
  final String gender;
  final String location;
  final String description;
  final List<String> imageUrl;

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
  });

  PetDetails.fromJson({required String pid, required Map<String, dynamic> json})
      : this(
          pid: pid,
          name: json['name'],
          type: json['type'],
          breed: json['breed'],
          age: json['age'],
          gender: json['gender'],
          location: json['location'],
          description: json['description'],
          imageUrl: json['image_url'].cast<String>(),
        );
}

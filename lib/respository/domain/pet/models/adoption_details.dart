part of '../pet_repository.dart';

class PetAdoptionDetails {
  final bool isAdopted;
  final DateTime? timestamp;
  final String? uid;

  PetAdoptionDetails({
    required this.isAdopted,
    this.timestamp,
    this.uid,
  });

  PetAdoptionDetails.fromJson(Map<String, dynamic> json)
      : this(
          isAdopted: json['is_adopted'],
          timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
          uid: json['uid'],
        );

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['uid'] = uid;
    map['is_adopted'] = isAdopted;
    map['timestamp'] = timestamp?.toIso8601String();
    return map;
  }
}

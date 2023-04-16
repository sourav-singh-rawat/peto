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

  Map<String, dynamic> toRequestJson() {
    var map = <String, dynamic>{};
    map['uid'] = KAppX.profile.state.userDetails!.uid;
    map['is_adopted'] = true;
    map['timestamp'] = DateTime.now().toIso8601String();
    return map;
  }
}

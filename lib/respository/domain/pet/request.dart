part of 'pet_repository.dart';

class PetListRequest extends RepositoryRequest {
  String? queryValue;
  Map<String, List<String>>? queryOptionsSelected;
  PetListRequest({
    this.queryValue,
    this.queryOptionsSelected,
  });

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  PetListRequest copyWith({
    String? queryValue,
    Map<String, List<String>>? queryOptionsSelected,
  }) {
    return PetListRequest(
      queryValue: queryValue ?? this.queryValue,
      queryOptionsSelected: queryOptionsSelected ?? this.queryOptionsSelected,
    );
  }
}

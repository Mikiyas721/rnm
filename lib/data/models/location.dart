import 'character.dart';

class LocationModel {
  String id;
  String name;
  String type;
  String dimension;
  List<CharacterModel> residents;
  String created;

  LocationModel({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.created,
  });

  factory LocationModel.fromJson(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      dimension: map['dimension'],
      residents: CharacterModel.fromList(map['residents']),
      created: map['created'],
    );
  }

  static List<LocationModel> fromList(List list) {
    List<LocationModel> locations;
    if (list != null) {
      locations = [];
      list.forEach((map) {
        locations.add(LocationModel.fromJson(map));
      });
    }
    return locations;
  }
}

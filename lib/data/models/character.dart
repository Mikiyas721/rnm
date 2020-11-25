import 'episode.dart';
import 'location.dart';

class CharacterModel {
  String id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  LocationModel origin;
  LocationModel location;
  String image;
  List<EpisodeModel> episode;
  String created;

  CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> map){
    return CharacterModel(
        id:map['id'],
        name:map['name'],
        status:map['status'],
        species:map['species'],
        type:map['type'],
        gender:map['gender'],
        origin:map['origin']==null?map['origin']:LocationModel.fromJson(map['origin']),
        location:map['location']==null?map['location']:LocationModel.fromJson(map['location']),
        image:map['image'],
        episode:EpisodeModel.fromList(map['episode']),
        created:map['created'],
    );
  }
  static List<CharacterModel> fromList(List list){
    List<CharacterModel> characters ;
    if(list!=null){
      characters = [];
      list.forEach((map) {
        characters.add(CharacterModel.fromJson(map));
      });
    }
    return characters;
  }
}
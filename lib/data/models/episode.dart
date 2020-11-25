import 'character.dart';

class EpisodeModel {
  String id;
  String name;
  String airDate;
  String episode;
  List<CharacterModel> characters;
  String created;

  EpisodeModel({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.created,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> map) {
    return EpisodeModel(
      id: map['id'],
      name: map['name'],
      airDate: map['air_date'],
      episode: map['episode'],
      characters: CharacterModel.fromList(map['characters']),
      created: map['created'],
    );
  }

  static List<EpisodeModel> fromList(List list) {
    List<EpisodeModel> episodes;
    if (list != null) {
      episodes = [];
      list.forEach((map) {
        episodes.add(EpisodeModel.fromJson(map));
      });
    }
    return episodes;
  }
}

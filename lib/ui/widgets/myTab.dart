import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'episodeDisplay.dart';
import 'locationDisplay.dart';
import 'characterDisplay.dart';

class MyTab extends StatelessWidget {
  final String type;
  final String query;

  MyTab({@required this.type, @required this.query});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(documentNode: gql(query)),
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (type == "Character")
                  return CharacterDisplay(
                    id: result.data['characters']['results'][index]['id'],
                    species: result.data['characters']['results'][index]['species'],
                    imageUrl: result.data['characters']['results'][index]['image'],
                    name: result.data['characters']['results'][index]['name'],
                    gender: result.data['characters']['results'][index]['gender'],
                  );
                else if (type == "Location")
                  return LocationDisplay(
                    id: result.data['locations']['results'][index]['id'],
                    name: result.data['locations']['results'][index]['name'],
                    type: result.data['locations']['results'][index]['type'],
                    dimension: result.data['locations']['results'][index]['dimension'],
                    created: result.data['locations']['results'][index]['created'],
                    residents: result.data['locations']['results'][index]['residents'].length,
                  );
                else
                  return EpisodeDisplay(
                    id: result.data['episodes']['results'][index]['id'],
                    name: result.data['episodes']['results'][index]['name'],
                    airDate: result.data['episodes']['results'][index]['air_date'],
                    episode: result.data['episodes']['results'][index]['episode'],
                    created: result.data['episodes']['results'][index]['created'],
                    characters: result.data['episodes']['results'][index]['characters'].length,
                  );
              },
              itemCount: getItemCount(result));
        }
      },
    );
  }

  int getItemCount(QueryResult result) {
    if (type == "Character")
      return result.data['characters']['results'].length;
    else if (type == "Location")
      return result.data['locations']['results'].length;
    else
      return result.data['episodes']['results'].length;
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'episodeDisplay.dart';
import 'locationDisplay.dart';
import 'characterDisplay.dart';

class MyTab extends StatelessWidget {
  final String type;
  final String query;
  final List<Map<String, dynamic>> ids;

  MyTab({@required this.type, @required this.query, @required this.ids});

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
          return result.data==null?Center(child:Text('No $type Found')):ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (type == "Character")
                  return CharacterDisplay(
                    id: result.data['characters']['results'][index]['id'],
                    species: result.data['characters']['results'][index]['species'],
                    imageUrl: result.data['characters']['results'][index]['image'],
                    name: result.data['characters']['results'][index]['name'],
                    gender: result.data['characters']['results'][index]['gender'],
                    selected: contains(ids, result.data['characters']['results'][index]['id']),
                  );
                else if (type == "Location")
                  return LocationDisplay(
                    id: result.data['locations']['results'][index]['id'],
                    name: result.data['locations']['results'][index]['name'],
                    type: result.data['locations']['results'][index]['type'],
                    dimension: result.data['locations']['results'][index]['dimension'],
                    created: result.data['locations']['results'][index]['created'],
                    residents: result.data['locations']['results'][index]['residents'],
                    selected: contains(ids, result.data['locations']['results'][index]['id']),
                  );
                else
                  return EpisodeDisplay(
                    id: result.data['episodes']['results'][index]['id'],
                    name: result.data['episodes']['results'][index]['name'],
                    airDate: result.data['episodes']['results'][index]['air_date'],
                    episode: result.data['episodes']['results'][index]['episode'],
                    created: result.data['episodes']['results'][index]['created'],
                    characters: result.data['episodes']['results'][index]['characters'],
                    selected: contains(ids, result.data['episodes']['results'][index]['id']),
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

  bool contains(List<Map<String, dynamic>> ids, String id) {
    for (var element in ids) {
      if (element['id'] == id) return true;
    }
    return false;
  }
}

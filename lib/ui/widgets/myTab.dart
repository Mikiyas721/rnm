import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'episodeDisplay.dart';
import 'locationDisplay.dart';
import 'characterDisplay.dart';

class MyTab extends StatefulWidget {
  final String type;
  final String query;
  final List<Map<String, dynamic>> ids;
  final Function(List<Map<String, dynamic>>) onIdsChanged;

  MyTab({@required this.type, @required this.query, @required this.ids, @required this.onIdsChanged});

  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  List<Map<String, dynamic>> localId;

  @override
  void initState() {
    localId = widget.ids;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(documentNode: gql(widget.query)),
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return result.data == null
              ? Center(child: Text('No ${widget.type} Found'))
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.type == "Character")
                      return CharacterDisplay(
                        id: result.data['characters']['results'][index]['id'],
                        species: result.data['characters']['results'][index]['species'],
                        imageUrl: result.data['characters']['results'][index]['image'],
                        name: result.data['characters']['results'][index]['name'],
                        gender: result.data['characters']['results'][index]['gender'],
                        selected: contains(localId, result.data['characters']['results'][index]['id']),
                        onIconPressed: (bool isIconSelected) {
                          setState(() {
                            isIconSelected
                                ? localId = add(result.data['characters']['results'][index]['id'])
                                : localId = remove(result.data['characters']['results'][index]['id']);
                          });
                          widget.onIdsChanged(localId);
                        },
                      );
                    else if (widget.type == "Location")
                      return LocationDisplay(
                        id: result.data['locations']['results'][index]['id'],
                        name: result.data['locations']['results'][index]['name'],
                        type: result.data['locations']['results'][index]['type'],
                        dimension: result.data['locations']['results'][index]['dimension'],
                        created: result.data['locations']['results'][index]['created'],
                        residents: result.data['locations']['results'][index]['residents'],
                        selected: contains(localId, result.data['locations']['results'][index]['id']),
                        onIconPressed: (bool isIconSelected) {
                          setState(() {
                            isIconSelected
                                ? localId = add(result.data['locations']['results'][index]['id'])
                                : localId = remove(result.data['locations']['results'][index]['id']);
                          });
                          widget.onIdsChanged(localId);
                        },
                      );
                    else
                      return EpisodeDisplay(
                        id: result.data['episodes']['results'][index]['id'],
                        name: result.data['episodes']['results'][index]['name'],
                        airDate: result.data['episodes']['results'][index]['air_date'],
                        episode: result.data['episodes']['results'][index]['episode'],
                        created: result.data['episodes']['results'][index]['created'],
                        characters: result.data['episodes']['results'][index]['characters'],
                        selected: contains(localId, result.data['episodes']['results'][index]['id']),
                        onIconPressed: (bool isIconSelected) {
                          setState(() {
                            isIconSelected
                                ? localId = add(result.data['episodes']['results'][index]['id'])
                                : localId = remove(result.data['episodes']['results'][index]['id']);
                          });
                          widget.onIdsChanged(localId);
                        },
                      );
                  },
                  itemCount: getItemCount(result));
        }
      },
    );
  }

  int getItemCount(QueryResult result) {
    if (widget.type == "Character")
      return result.data['characters']['results'].length;
    else if (widget.type == "Location")
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

  List<Map<String, dynamic>> remove(String id) {
    List<Map<String, dynamic>> newList = [];
    for (Map<String, dynamic> element in localId) {
      if (element['id'] == id) {
        continue;
      }
      newList.add(element);
    }
    return newList;
  }

  List<Map<String, dynamic>> add(String id) {
    List<Map<String, dynamic>> newList = [];
    localId.forEach((element) {
      newList.add(element);
    });
    newList.add({'id': id});
    return newList;
  }
}

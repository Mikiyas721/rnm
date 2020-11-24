import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ricknmorty/utils/mixin/tabMixin.dart';
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

class _MyTabState extends State<MyTab> with TabMixin {
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
                        character: result.data['characters']['result'][index],
                        selected: contains(localId, result.data['characters']['results'][index]['id']),
                        onIconPressed: (bool isIconSelected) {
                          setState(() {
                            isIconSelected
                                ? localId = add(result.data['characters']['results'][index]['id'],localId)
                                : localId = remove(result.data['characters']['results'][index]['id'],localId);
                          });
                          widget.onIdsChanged(localId);
                        },
                      );
                    else if (widget.type == "Location")
                      return LocationDisplay(
                        location: result.data['locations']['results'][index],
                        selected: contains(localId, result.data['locations']['results'][index]['id']),
                        onIconPressed: (bool isIconSelected) {
                          setState(() {
                            isIconSelected
                                ? localId = add(result.data['locations']['results'][index]['id'],localId)
                                : localId = remove(result.data['locations']['results'][index]['id'],localId);
                          });
                          widget.onIdsChanged(localId);
                        },
                      );
                    else
                      return EpisodeDisplay(
                        episode: result.data['episodes']['results'][index],
                        selected: contains(localId, result.data['episodes']['results'][index]['id']),
                        onIconPressed: (bool isIconSelected) {
                          setState(() {
                            isIconSelected
                                ? localId = add(result.data['episodes']['results'][index]['id'],localId)
                                : localId = remove(result.data['episodes']['results'][index]['id'],localId);
                          });
                          widget.onIdsChanged(localId);
                        },
                      );
                  },
                  itemCount: getItemCount(result,widget.type));
        }
      },
    );
  }
}

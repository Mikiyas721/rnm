import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../data/models/episode.dart';
import '../../ui/widgets/episodeDisplay.dart';
import '../../utils/mixin/tabMixin.dart';

class EpisodesPage extends StatefulWidget {
  final String query;
  final List<Map<String, dynamic>> ids;
  final Function(List<Map<String, dynamic>>) onIdsChanged;

  EpisodesPage({@required this.query, @required this.ids, @required this.onIdsChanged});

  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> with TabMixin {
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
        if (result.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return result.data == null
              ? Center(child: Text('No Episode Found'))
              :ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return EpisodeDisplay(
                  episode: EpisodeModel.fromJson(result.data['episodes']['results'][index]),
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
              itemCount: getItemCount(result, "Episode"));
        }
      },
    );;
  }

}
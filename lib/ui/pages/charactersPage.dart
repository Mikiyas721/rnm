import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../data/models/character.dart';
import '../../utils/mixin/tabMixin.dart';
import '../../ui/widgets/characterDisplay.dart';

class CharactersPage extends StatefulWidget {
  final String query;
  final List<Map<String, dynamic>> ids;
  final Function(List<Map<String, dynamic>>) onIdsChanged;

  CharactersPage({@required this.query, @required this.ids, @required this.onIdsChanged});

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> with TabMixin {
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
              ? Center(child: Text('No Character Found'))
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return CharacterDisplay(
                      character: CharacterModel.fromJson(result.data['characters']['results'][index]),
                      selected: contains(localId, result.data['characters']['results'][index]['id']),
                      onIconPressed: (bool isIconSelected) {
                        setState(() {
                          isIconSelected
                              ? localId = add(result.data['characters']['results'][index]['id'], localId)
                              : localId = remove(result.data['characters']['results'][index]['id'], localId);
                        });
                        widget.onIdsChanged(localId);
                      },
                    );
                  },
                  itemCount: getItemCount(result, "Character"));
        }
      },
    );
  }
}

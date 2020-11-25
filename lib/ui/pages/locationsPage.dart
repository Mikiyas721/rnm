import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../data/models/location.dart';
import '../../ui/widgets/locationDisplay.dart';
import '../../utils/mixin/tabMixin.dart';

class LocationsPage extends StatefulWidget {
  final String query;
  final List<Map<String, dynamic>> ids;
  final Function(List<Map<String, dynamic>>) onIdsChanged;

  LocationsPage({@required this.query, @required this.ids, @required this.onIdsChanged});

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> with TabMixin {
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
              ? Center(child: Text('No Location Found'))
              :ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return LocationDisplay(
                  location: LocationModel.fromJson(result.data['locations']['results'][index]),
                  selected: contains(localId, result.data['locations']['results'][index]['id']),
                  onIconPressed: (bool isIconSelected) {
                    setState(() {
                      isIconSelected
                          ? localId = add(result.data['locations']['results'][index]['id'], localId)
                          : localId = remove(result.data['locations']['results'][index]['id'], localId);
                    });
                    widget.onIdsChanged(localId);
                  },
                );
              },
              itemCount: getItemCount(result, "Location"));
        }
      },
    );;
  }

}
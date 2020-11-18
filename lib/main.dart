import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './ui/widgets/characterDisplay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  MyApp()
      : client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: 'https://rickandmortyapi.com/graphql'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: Text('Characters'),
              ),
              body: Query(
                options: QueryOptions(documentNode: gql("""
               query GetCharacters{
                 characters {
                   results {
                     id
                     name
                     image
                     species
                     type
                     gender
                   }
                 }
               }
               """)),
                builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
                  if (result.data == null) {
                    return Center(child: CircularProgressIndicator(),);
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return CharacterDisplay(
                          species: result.data['characters']['results'][index]['species'],
                          imageUrl: result.data['characters']['results'][index]['image'],
                          name: result.data['characters']['results'][index]['name'],
                          gender: result.data['characters']['results'][index]['gender'],
                        );
                      },
                      itemCount: result.data['characters']['results'].length,
                    );
                  }
                },
              )),
        ));
  }
}

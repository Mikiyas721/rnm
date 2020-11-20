import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './data/databaseManager.dart';
import './ui/pages/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager.createTables();

  runApp(MyApp(await DatabaseManager.fetchFavouriteCharacters(),
      await DatabaseManager.fetchFavouriteLocations(), await DatabaseManager.fetchFavouriteEpisode()));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  final characters;
  final locations;
  final episodes;

  MyApp(this.characters, this.locations, this.episodes)
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
          home: HomePage(
            characters: characters,
            episodes: locations,
            locations: episodes,
          ),
        ));
  }
}

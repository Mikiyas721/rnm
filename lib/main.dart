import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './injector.dart';
import './data/databaseManager.dart';
import './ui/pages/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  inject();
  DatabaseManager db = GetIt.instance.get();
  await db.createTables();
  runApp(MyApp(await db.fetchFavouriteCharacters(), await db.fetchFavouriteLocations(),
      await db.fetchFavouriteEpisode()));
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

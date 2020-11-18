import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './ui/pages/homePage.dart';

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
          routes:routes,
          initialRoute: '/',
        ));
  }
}

final routes = {
  '/': (BuildContext context) => HomePage()
};

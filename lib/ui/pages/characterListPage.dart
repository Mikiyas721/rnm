import 'package:flutter/material.dart';
import '../../data/models/character.dart';

class CharacterListPage extends StatelessWidget {
  final String title;
  final List<Character> characters;

  CharacterListPage({@required this.title, @required this.characters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(characters[index].name),
          );
        },
      ),
    );
  }
}

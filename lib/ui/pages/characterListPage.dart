import 'package:flutter/material.dart';
import '../../utils/mixin/formatterMixin.dart';
import '../../data/models/character.dart';

class CharacterListPage extends StatelessWidget with FormatterMixin {
  final String title;
  final List<CharacterModel> characters;

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
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(characters[index].image),
              ),
              title: Text(characters[index].name),
              subtitle: Text(
                characters[index].gender,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Image.network(characters[index].image, width: MediaQuery.of(context).size.width*0.9,),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name :- ${characters[index].name}'),
                            Text('Gender :- ${characters[index].gender}'),
                            Text('Type :- ${characters[index].type}'),
                            Text('Species :- ${characters[index].species}'),
                            Text('Status :- ${characters[index].status}'),
                            Text('Created :- ${getDate(characters[index].created)}'),
                          ],
                        ),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close'))
                        ],
                      );
                    });
              });
        },
      ),
    );
  }
}

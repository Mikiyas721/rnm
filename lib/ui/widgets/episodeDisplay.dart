import 'package:flutter/material.dart';

class EpisodeDisplay extends StatelessWidget {
  final String id;
  final String name;
  final String airDate;
  final String episode;
  final String created;
  final int characters;

  EpisodeDisplay({
    @required this.id,
    @required this.name,
    @required this.airDate,
    @required this.episode,
    @required this.created,
    @required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 15, top: 15, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(episode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('\nName :- $name', style: TextStyle(fontSize: 16)),
            Text('Air Date :- $airDate', style: TextStyle(fontSize: 16)),
            Text('Created :- $created', style: TextStyle(fontSize: 16)),
            Text('Character count :- $characters', style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}

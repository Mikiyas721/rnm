import 'package:flutter/material.dart';
import '../../data/models/episode.dart';

class EpisodeListPage extends StatelessWidget {
  final String title;
  final String url;
  final List<EpisodeModel> episodes;

  EpisodeListPage({@required this.title, @required this.url, @required this.episodes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(url),
              ),
            ),
            Text(title)
          ],
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: episodes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(episodes[index].episode),
              subtitle: Text(
                episodes[index].name,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {});
        },
      ),
    );
  }
}

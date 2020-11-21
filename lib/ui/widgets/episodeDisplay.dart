import 'package:flutter/material.dart';
import '../pages/characterListPage.dart';
import '../../data/databaseManager.dart';

class EpisodeDisplay extends StatefulWidget {
  final String id;
  final String name;
  final String airDate;
  final String episode;
  final String created;
  final List characters;
  final Function(bool isSelected) onIconPressed;

  final selected;

  EpisodeDisplay(
      {@required this.id,
      @required this.name,
      @required this.airDate,
      @required this.episode,
      @required this.created,
      @required this.characters,
        @required this.onIconPressed,
      this.selected = false});

  @override
  _EpisodeDisplayState createState() => _EpisodeDisplayState();
}

class _EpisodeDisplayState extends State<EpisodeDisplay> {
  bool isIconSelected;

  @override
  void initState() {
    isIconSelected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return CharacterListPage(title: widget.episode, characters: widget.characters);
          }));
        },
        child: Card(
          elevation: 3,
          margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: isIconSelected
                          ? Icon(
                              Icons.star,
                              size: 32,
                              color: Colors.yellow,
                            )
                          : Icon(Icons.star_border, size: 32),
                      onPressed: () {
                        setState(() {
                          isIconSelected = !isIconSelected;
                          isIconSelected
                              ? DatabaseManager.addFavouriteEpisodes(widget.id)
                              : DatabaseManager.deleteEpisode(widget.id);
                        });
                        widget.onIconPressed(isIconSelected);
                      })),
              Container(
                padding: EdgeInsets.only(left: 30, right: 15, top: 15, bottom: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.episode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('\nName :- ${widget.name}', style: TextStyle(fontSize: 16)),
                    Text('Air Date :- ${widget.airDate}', style: TextStyle(fontSize: 16)),
                    Text('Created :- ${widget.created}', style: TextStyle(fontSize: 16)),
                    Text('Character count :- ${widget.characters.length}', style: TextStyle(fontSize: 16))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

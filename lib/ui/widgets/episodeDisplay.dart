import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ricknmorty/utils/mixin/formatterMixin.dart';
import '../../data/models/episode.dart';
import '../pages/characterListPage.dart';
import '../../data/databaseManager.dart';

class EpisodeDisplay extends StatefulWidget {
  final EpisodeModel episode;
  final Function(bool isSelected) onIconPressed;

  final selected;

  EpisodeDisplay({@required this.episode, @required this.onIconPressed, this.selected = false});

  @override
  _EpisodeDisplayState createState() => _EpisodeDisplayState();
}

class _EpisodeDisplayState extends State<EpisodeDisplay> with FormatterMixin {
  bool isIconSelected;
  DatabaseManager db = GetIt.instance.get();


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
            return CharacterListPage(title: widget.episode.episode, characters: widget.episode.characters);
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
                        });
                        isIconSelected
                            ? db.addFavouriteEpisodes(widget.episode.id)
                            : db.deleteEpisode(widget.episode.id);
                        widget.onIconPressed(isIconSelected);
                      })),
              Container(
                padding: EdgeInsets.only(left: 30, right: 15, top: 15, bottom: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.episode.episode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('\nName :- ${widget.episode.name}', style: TextStyle(fontSize: 16)),
                    Text('Air Date :- ${widget.episode.airDate}', style: TextStyle(fontSize: 16)),
                    Text('Created :- ${getDate(widget.episode.created)}', style: TextStyle(fontSize: 16)),
                    Text('Character count :- ${widget.episode.characters.length}', style: TextStyle(fontSize: 16))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

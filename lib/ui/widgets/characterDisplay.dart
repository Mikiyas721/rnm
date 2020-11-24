import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/models/character.dart';
import '../../data/databaseManager.dart';
import '../widgets/imageView.dart';

class CharacterDisplay extends StatefulWidget {
  final Character character;
  final bool selected;
  final Function(bool isSelected) onIconPressed;

  CharacterDisplay(
      {@required this.character,
      @required this.onIconPressed,
      this.selected = false});

  @override
  _CharacterDisplayState createState() => _CharacterDisplayState();
}

class _CharacterDisplayState extends State<CharacterDisplay> {
  bool isIconSelected;
  NetworkImage characterImage;
  bool isImageLoading = true;
  DatabaseManager db = GetIt.instance.get();

  @override
  void initState() {
    isIconSelected = widget.selected;
    characterImage = NetworkImage(widget.character.image);
    characterImage.resolve(ImageConfiguration()).addListener(ImageStreamListener((_, __) {
      if (mounted) {
        setState(() {
          isImageLoading = false;
        });
      }
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        ? db.addFavouriteCharacter(widget.character.id)
                        : db.deleteCharacter(widget.character.id);
                    widget.onIconPressed(isIconSelected);
                  })),
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                isImageLoading
                    ? CircleAvatar(
                        child: Text('${widget.character.name[0]}', style: TextStyle(fontSize: 20)),
                        radius: 50,
                      )
                    : GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: characterImage,
                          radius: 50,
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return MyImageView(
                              imageUrl: widget.character.image,
                            );
                          }));
                        },
                      ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          'Name :- ${widget.character.name}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                        ),
                        width: MediaQuery.of(context).size.width * 0.55,
                      ),
                      Text('Gender :- ${widget.character.gender}', style: TextStyle(fontSize: 16)),
                      Text('Species :- ${widget.character.species}', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

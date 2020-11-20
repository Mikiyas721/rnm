import 'package:flutter/material.dart';
import '../../data/databaseManager.dart';
import '../widgets/imageView.dart';

class CharacterDisplay extends StatefulWidget {
  final id;
  final imageUrl;
  final name;
  final gender;
  final species;
  final selected;

  CharacterDisplay(
      {@required this.id,
      @required this.imageUrl,
      @required this.name,
      @required this.gender,
      @required this.species,
      this.selected = false});

  @override
  _CharacterDisplayState createState() => _CharacterDisplayState();
}

class _CharacterDisplayState extends State<CharacterDisplay> {
  bool isIconSelected;
  NetworkImage characterImage;
  bool isImageLoading = true;

  @override
  void initState() {
    isIconSelected = widget.selected;
    characterImage = NetworkImage(widget.imageUrl);
    characterImage
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((_,__) {
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
                      isIconSelected
                          ? DatabaseManager.addFavouriteCharacter(widget.id)
                          : DatabaseManager.deleteCharacter(widget.id);
                    });
                  })),
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                isImageLoading
                    ? CircleAvatar(
                        child: Text('${widget.name[0]}', style:TextStyle(fontSize:20)),
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
                              imageUrl: widget.imageUrl,
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
                          'Name :- ${widget.name}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                        ),
                        width: MediaQuery.of(context).size.width * 0.55,
                      ),
                      Text('Gender :- ${widget.gender}', style: TextStyle(fontSize: 16)),
                      Text('Species :- ${widget.species}', style: TextStyle(fontSize: 16))
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

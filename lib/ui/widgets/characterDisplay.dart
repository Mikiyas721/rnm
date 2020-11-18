import 'package:flutter/material.dart';

class CharacterDisplay extends StatelessWidget {
  final id;
  final imageUrl;
  final name;
  final gender;
  final species;

  CharacterDisplay(
      {@required this.id, @required this.imageUrl, @required this.name, @required this.gender, @required this.species});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 50,
                ),
                onTap: () {
                  print('Show Image');
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
                        'Name :- $name',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                      width: MediaQuery.of(context).size.width * 0.55,
                    ),
                    Text('Gender :- $gender', style: TextStyle(fontSize: 16)),
                    Text('Species :- $species', style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }
}

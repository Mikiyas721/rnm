import 'package:flutter/material.dart';
import '../../data/databaseManager.dart';

class LocationDisplay extends StatefulWidget {
  final String id;
  final String name;
  final String type;
  final String dimension;
  final String created;
  final int residents;
  final bool selected;

  LocationDisplay(
      {@required this.id,
      @required this.name,
      @required this.type,
      @required this.dimension,
      @required this.created,
      @required this.residents,
      this.selected = false});

  @override
  _LocationDisplayState createState() => _LocationDisplayState();
}

class _LocationDisplayState extends State<LocationDisplay> {
  bool isIconSelected;

  @override
  void initState() {
    isIconSelected = widget.selected;
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
            padding: EdgeInsets.only(left: 30, bottom: 15, top: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\nType :- ${widget.type}', style: TextStyle(fontSize: 16)),
                Text('Dimension :- ${widget.dimension}', style: TextStyle(fontSize: 16)),
                Text('Created :- ${widget.created}', style: TextStyle(fontSize: 16)),
                Text('Character count :- ${widget.residents}', style: TextStyle(fontSize: 16))
              ],
            ),
          )
        ],
      ),
    );
  }
}

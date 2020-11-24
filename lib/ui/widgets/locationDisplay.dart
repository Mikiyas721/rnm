import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/models/location.dart';
import '../pages/characterListPage.dart';
import '../../data/databaseManager.dart';

class LocationDisplay extends StatefulWidget {
  final Location location;
  final bool selected;
  final Function(bool isSelected) onIconPressed;

  LocationDisplay(
      {@required this.location,
      @required this.onIconPressed,
      this.selected = false});

  @override
  _LocationDisplayState createState() => _LocationDisplayState();
}

class _LocationDisplayState extends State<LocationDisplay> {
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
          return CharacterListPage(title: widget.location.name, characters: widget.location.residents);
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
                          ? db.addFavouriteLocation(widget.location.id)
                          : db.deleteLocation(widget.location.id);
                      widget.onIconPressed(isIconSelected);
                    })),
            Container(
              padding: EdgeInsets.only(left: 30, bottom: 15, top: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.location.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('\nType :- ${widget.location.type}', style: TextStyle(fontSize: 16)),
                  Text('Dimension :- ${widget.location.dimension}', style: TextStyle(fontSize: 16)),
                  Text('Created :- ${widget.location.created}', style: TextStyle(fontSize: 16)),
                  Text('Character count :- ${widget.location.residents.length}', style: TextStyle(fontSize: 16))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

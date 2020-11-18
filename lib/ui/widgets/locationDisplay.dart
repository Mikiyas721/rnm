import 'package:flutter/material.dart';

class LocationDisplay extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final String dimension;
  final String created;
  final int residents;

  LocationDisplay({
    @required this.id,
    @required this.name,
    @required this.type,
    @required this.dimension,
    @required this.created,
    @required this.residents,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: EdgeInsets.only(left: 30, bottom: 15, top: 15, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('\nType :- $type', style: TextStyle(fontSize: 16)),
            Text('Dimension :- $dimension', style: TextStyle(fontSize: 16)),
            Text('Created :- $created', style: TextStyle(fontSize: 16)),
            Text('Character count :- $residents', style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}

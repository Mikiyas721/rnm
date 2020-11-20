import 'package:flutter/material.dart';

class MyImageView extends StatelessWidget {
  final String imageUrl;

  MyImageView({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          imageUrl,
        ),
      ),
    );
  }
}

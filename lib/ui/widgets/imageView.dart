import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:toast/toast.dart';

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
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async{
          String id = await ImageDownloader.downloadImage(imageUrl);
          if(id!=null) Toast.show('Image Saved', context);
          else Toast.show('Unable to save image', context);
        },
        child: Icon(
          Icons.file_download,
          size: 40,
        ),
      ),*/
    );
  }
}

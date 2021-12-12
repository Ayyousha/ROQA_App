
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerScreen extends StatelessWidget {
  var photo;

  PhotoViewerScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0; // 1.0 means normal animation speed.

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: _buildAppBar(context),
      body: Center(
        child: Hero(
          tag: photo,
          child: Container(
              child: PhotoView(
                imageProvider: NetworkImage(photo),
              )
          ),
        ),
      ),
    );
  }

  /// App Bar
  AppBar _buildAppBar(context)=> AppBar(
    elevation: 50,
    backgroundColor:Colors.white10,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black,
    ),
    leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    ),
  );
}

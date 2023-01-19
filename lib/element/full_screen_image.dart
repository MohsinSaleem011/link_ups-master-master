import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatefulWidget {
  final String imageURL;
  final String tag;

  const FullScreenImage({required this.imageURL, required this.tag, Key? key})
      : super(key: key);
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Container(
            child: PhotoView(
              imageProvider: NetworkImage(widget.imageURL),
              loadingBuilder: (context, url) => new CircularProgressIndicator(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

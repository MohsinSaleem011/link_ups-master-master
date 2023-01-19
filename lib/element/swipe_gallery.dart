import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class SwipeGallery extends StatefulWidget {
  final List<dynamic> image;
  final int index;
  const SwipeGallery({required this.image, required this.index, Key? key})
      : super(key: key);
  @override
  _SwipeGalleryState createState() => _SwipeGalleryState();
}

class _SwipeGalleryState extends State<SwipeGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: new Swiper(
          index: widget.index,
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              widget.image[index],
              fit: BoxFit.fitWidth,
            );
          },
          itemCount: widget.image.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
          duration: 300,
          viewportFraction: 0.8,
          scale: 0.8,
          onTap: (index) {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

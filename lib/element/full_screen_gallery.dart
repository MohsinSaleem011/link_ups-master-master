import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenGallery extends StatefulWidget {
  final List<dynamic> galleryItem;
  final int index;
  const FullScreenGallery(
      {required this.galleryItem, required this.index, Key? key})
      : super(key: key);
  @override
  _FullScreenGalleryState createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  final imageList = [
    'assets/profile/a.jpg',
    'assets/profile/b.jpg',
    'assets/profile/c.jpg',
    'assets/profile/d.jpg',
  ];

  PageController? _controller;

  @override
  void initState() {
    setState(() {
      _controller = PageController(initialPage: widget.index, keepPage: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: PhotoViewGallery.builder(
              itemCount: imageList.length,
              pageController: _controller,
              builder: (context, index) {
                String myImg = widget.galleryItem[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(
                    myImg,
                  ),
                  initialScale: PhotoViewComputedScale.contained * 0.95,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: index.toString()),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.black,
              ),
              enableRotation: true,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.orange,
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                  ),
                ),
              ),
              onPageChanged: (int index) {
                setState(() {});
              },
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:link_up/helper/shared_manager.dart';
import 'package:link_up/model/PlaceDetailsModel.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ZoomablePhotos extends StatefulWidget {
  final List<Photo> photos;
  ZoomablePhotos({Key? key, required this.photos}) : super(key: key);

  @override
  _ZoomablePhotosState createState() => _ZoomablePhotosState();
}

class _ZoomablePhotosState extends State<ZoomablePhotos> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new SafeArea(
      child: Stack(
        children: <Widget>[
          new PhotoViewGallery(
            pageOptions: setPhotoGallery(this.widget.photos),
            backgroundDecoration: BoxDecoration(color: Colors.white),
          ),
          new Container(
              padding: new EdgeInsets.only(left: 0),
              height: 40,
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}

List<PhotoViewGalleryPageOptions> setPhotoGallery(dynamic photos) {
  List<PhotoViewGalleryPageOptions> myList = [];

  for (var i = 0; i < photos.length; i++) {
    var photoGal = PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(
          SharedManager.shared.getImageURL(photos[i].photoReference)),
    );
    myList.add(photoGal);
  }
  return myList;
}

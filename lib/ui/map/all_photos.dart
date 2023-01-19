import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/helper/shared_manager.dart';
import 'package:link_up/model/PlaceDetailsModel.dart';
import 'package:link_up/ui/map/zoom_photos.dart';

class AllPhotos extends StatefulWidget {
  List<Photo> photos = [];
  AllPhotos({Key? key, required this.photos}) : super(key: key);

  @override
  _AllPhotosState createState() => _AllPhotosState();
}

class _AllPhotosState extends State<AllPhotos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: SharedManager.shared.getThemeType(),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('all_photos'.tr),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: new GridView.count(
          crossAxisCount: 2,
          children:
              new List<Widget>.generate(this.widget.photos.length, (index) {
            return new GridTile(
              child: new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ZoomablePhotos(
                        photos: this.widget.photos,
                      ),
                    ),
                  );
                },
                child: new Card(
                    color: Colors.white,
                    child: new Image(
                      image: NetworkImage(SharedManager.shared.getImageURL(
                          this.widget.photos[index].photoReference)),
                      fit: BoxFit.cover,
                    )),
              ),
            );
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/map_controller.dart';
import 'package:link_up/helper/drawer_manager.dart';
import 'package:link_up/model/PlaceListModel.dart';
import 'package:link_up/ui/map/place_detail_page.dart';
import 'package:share_plus/share_plus.dart';

class PlaceListPage extends StatefulWidget {
  final String placeTitle;
  PlaceListPage({Key? key, required this.placeTitle}) : super(key: key);

  @override
  _PlaceListPageState createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  MapController mapController = Get.find(tag: MapController().toString());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.clearPlaceList();
    });
    GeolocatorPlatform.instance.getCurrentPosition().then((value) {
      mapController.fetchPlaceList(widget.placeTitle, value.latitude.toString(),
          value.longitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<MapController>(
        init: mapController,
        builder: (_) {
          return new MaterialApp(
            home: new Scaffold(
              appBar: new AppBar(
                centerTitle: true,
                backgroundColor: Color.fromARGB(255, 56, 171, 216),
                title: new Text("${widget.placeTitle}"),
                leading: new IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: ListView.builder(
                itemCount:
                    mapController.restaurantList?.value.results?.length ?? 0,
                itemBuilder: (context, index) {
                  List list = mapController.restaurantList!.value.results!;
                  if (list.isNotEmpty == true) {
                    return _setRestaurantView(width, list[index], context);
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          );
        });
  }

  _setRestaurantView(double width, Result place, BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlaceDetailPage(
                  imageUrl:
                      mapController.getImageURL(place.photos[0].photoReference),
                  placeID: place.placeId,
                  placeName: place.name,
                )));
      },
      child: new Container(
        width: width,
        height: 450,
        // color: Colors.amber,
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: new Container(
                padding: new EdgeInsets.only(left: 15),
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(place.icon),
                        backgroundColor: Colors.transparent),
                    SizedBox(
                      width: 10,
                    ),
                    new Expanded(
                      flex: 4,
                      child: new Container(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              place.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            new Text(
                              place.vicinity,
                              style: new TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new Container(
                        // color: Colors.red,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              place.rating.toString(),
                              style: new TextStyle(
                                color: Colors.amber,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            new Icon(Icons.star, color: Colors.amber)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: new Container(
                decoration: new BoxDecoration(
                    image: DecorationImage(
                        // image: AssetImage('Assets/restaurant.jpg'),
                        image: NetworkImage(mapController
                            .getImageURL(place.photos[0].photoReference)),
                        fit: BoxFit.cover)),
              ),
            ),
            Expanded(
              flex: 1,
              child: new Container(
                // color: Colors.pink,
                child: Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new IconButton(
                              icon: Icon(Icons.thumb_up, color: Colors.teal),
                              onPressed: () {},
                            ),
                            new IconButton(
                              icon: Icon(Icons.share, color: Colors.teal),
                              onPressed: () {
                                Share.share(
                                    'https://www.google.com/maps/search/?api=1&query=${place.geometry.location.lat},${place.geometry.location.lng}');
                              },
                            ),
                          ],
                        ),
                        new IconButton(
                          icon: Icon(Icons.place, color: Colors.red),
                          onPressed: () {
                            // _openMap();
                            MapUtils.openMap(place.geometry.location.lat,
                                place.geometry.location.lng);
                          },
                        ),
                      ],
                    ),
                    new Container(
                      width: width,
                      color: Colors.grey,
                      height: 1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

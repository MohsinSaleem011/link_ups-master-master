import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:link_up/get_controller/map_controller.dart';
import 'package:link_up/ui/map/all_photos.dart';
import 'package:link_up/helper/drawer_manager.dart';
import 'package:link_up/helper/shared_manager.dart';
import 'package:link_up/model/PlaceDetailsModel.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'all_reviews.dart';

class PlaceDetailPage extends StatefulWidget {
  final String placeID;
  final String imageUrl;
  final String placeName;
  PlaceDetailPage({
    Key? key,
    required this.placeID,
    required this.imageUrl,
    required this.placeName,
  }) : super(key: key);

  @override
  _PlaceDetailPageState createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  MapController mapController = Get.find(tag: MapController().toString());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.clearPlaceDetails();
    });
    GeolocatorPlatform.instance.getCurrentPosition().then((value) {
      mapController.getPlaceDetails(widget.placeID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double latitude = 0;
    double longitude = 0;

    return GetBuilder<MapController>(
        init: mapController,
        builder: (_) {
          Result? list = mapController.restaurantDetails?.value.result;
          return new MaterialApp(
            home: new Scaffold(
              primary: true,
              appBar: new AppBar(
                centerTitle: true,
                title: Text(
                  widget.placeName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    fontSize: 20,
                  ),
                ),
                leading: new IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: new SafeArea(
                child: new Hero(
                    tag: "RestaurantDescription",
                    child: Column(
                      children: <Widget>[
                        if (list != null)
                          Expanded(
                            flex: 12,
                            child: ListView(
                              children: <Widget>[
                                _setImageStackView(
                                    width, list, context, widget.imageUrl),
                                _setSocialWidgets(width, list),
                                _setGoogleMapWidgets(width, list),
                                _setRestaurantDetails(width, list),
                                _setPhotosWidgets(width, list),
                                _setReviewWidgets(width, list, context)
                              ],
                            ),
                          ),
                        Expanded(
                          flex: 0,
                          child: new Container(
                            color: AppColors.PRIMARY_COLOR,
                            width: width,
                            height: 45,
                            child: new Center(
                              child: new ElevatedButton(
                                child: new Text(
                                  'track_on_map'.tr,
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                onPressed: () {
                                  MapUtils.openMap(latitude, longitude);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          );
        });
  }
}

_setImageStackView(
    double width, Result response, BuildContext context, String imageUrl) {
  return new Stack(
    children: <Widget>[
      new Container(
        width: width,
        height: width - 100,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.fill)),
      ),
      new Container(
        padding: new EdgeInsets.only(top: 5, bottom: 5),
        width: width,
        height: width - 100,
        color: Colors.grey.withOpacity(0.3),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new IconButton(
              icon:
                  Icon(Icons.arrow_back_ios, color: Colors.amber.withAlpha(0)),
              onPressed: () {},
            ),
            new Container(
              padding: new EdgeInsets.only(
                left: 15,
              ),
              width: width,
              height: 80,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    flex: 2,
                    child: new Container(
                      // color: Colors.red,
                      child: new Text(
                        response.name,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: new Container(
                        width: 50,
                        // color: Colors.white,
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              response.rating.toString(),
                              style: new TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            new Icon(Icons.star, color: Colors.orange)
                          ],
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

_setSocialWidgets(double width, Result response) {
  return new Container(
    width: width,
    height: 80,
    // color: Colors.red,
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.share,
              color: Colors.black,
            ),
            new Text('share'.tr),
            new Text(
              '500',
              style: new TextStyle(color: Colors.orange),
            )
          ],
        ),
        SizedBox(
          width: 30,
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.star_border,
              color: Colors.black,
            ),
            new Text('review'.tr),
            new Text(
              response.userRatingsTotal.toString(),
              style: new TextStyle(color: Colors.orange),
            )
          ],
        ),
        SizedBox(
          width: 30,
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
            new Text('photos'.tr),
            new Text(
              '50',
              style: new TextStyle(color: Colors.orange),
            )
          ],
        )
      ],
    ),
  );
}

_setGoogleMapWidgets(double width, Result response) {
  Set<Marker> markers = Set();
  markers.addAll([
    Marker(
        markerId: MarkerId('value'),
        position: LatLng(double.parse(DrawerManager.shared.latitude),
            double.parse(DrawerManager.shared.latitude))),
  ]);

  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(double.parse(DrawerManager.shared.latitude),
        double.parse(DrawerManager.shared.latitude)),
    zoom: 12,
  );

  return new Container(
    width: width,
    height: 150,
    // color: Colors.red,
    child: new Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            // _controller.complete(controller);
          },
          markers: markers,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: new Container(
            padding: new EdgeInsets.only(bottom: 5, left: 15, right: 15),
            child: new Text(
              response.vicinity,
              style: new TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    ),
  );
}

_setPhotosWidgets(double width, Result response) {
  return new Container(
    width: width,
    height: 170,
    padding: new EdgeInsets.all(15),
    // color: Colors.red,
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          'photos'.tr,
          style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        new Container(
          height: 109,
          // color: Colors.lightBlue,
          child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: response.photos.length > 4 ? 4 : response.photos.length,
            itemBuilder: (context, index) {
              return new Container(
                padding: new EdgeInsets.all(5),
                child: new Stack(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllPhotos(
                                  photos: response.photos,
                                )));
                      },
                      child: new Container(
                        padding: new EdgeInsets.all(5),
                        width: 109,
                        height: 109,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(SharedManager.shared
                                    .getImageURL(
                                        response.photos[index].photoReference)),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    _setExtraPhotosButton(
                        response.photos.length, index, response, context)
                  ],
                ),
              );
            },
          ),
        )
      ],
    ),
  );
}

_setExtraPhotosButton(
    int count, int index, Result response, BuildContext context) {
  var total = (count - (index + 1));
  if (count > 4) {
    if (index == 3) {
      return new GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AllPhotos(
                    photos: response.photos,
                  )));
        },
        child: new Container(
          width: 109,
          height: 109,
          color: Colors.grey.withOpacity(0.5),
          child: new Center(
            child: new Text(
              "+$total",
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );
    } else
      return new Text('');
  } else
    return new Text('');
}

_setRestaurantDetails(double width, Result response) {
  return new Container(
    // color: Colors.red,
    width: width,
    height: 180,
    padding: new EdgeInsets.all(15),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'call'.tr,
              style: new TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            new GestureDetector(
              onTap: () {
                launch("tel://${response.internationalPhoneNumber.toString()}");
              },
              child: new Text(
                response.internationalPhoneNumber.toString(),
                style: new TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'average_cost'.tr,
              style: new TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            new Text(
              '\$20-\$90',
              style: new TextStyle(
                color: Colors.orange,
                fontSize: 18,
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'availability'.tr,
              style: new TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            new Text(
              (response.openingHours?.openNow ?? false)
                  ? "open_now".tr
                  : "closed".tr,
              style: new TextStyle(
                color: Colors.orange,
                fontSize: 18,
              ),
            )
          ],
        ),
      ],
    ),
  );
}

_setReviewWidgets(double width, Result response, BuildContext context) {
  return new Container(
    width: width,
    height: ((response.reviews.length > 3 ? 3 : response.reviews.length) * 220)
            .toDouble() +
        70,
    // color: Colors.green,
    padding: new EdgeInsets.all(15),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              "reviews".tr,
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllReview(
                          response: response,
                        )));
              },
              child: response.reviews.length > 3
                  ? new Text(
                      "sell_all".tr,
                      style: new TextStyle(
                          color: Colors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )
                  : new Text(''),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        new Container(
          width: width,
          height: (220 *
                  (response.reviews.length > 3 ? 3 : response.reviews.length))
              .toDouble(),
          child: new ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                response.reviews.length > 3 ? 3 : response.reviews.length,
            itemBuilder: (context, index) {
              return new Container(
                height: 220,
                // color:Colors.amberAccent,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: new Container(
                        // color: Colors.blue,
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              height: 70,
                              width: 70,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  image: DecorationImage(
                                      image: NetworkImage(response
                                          .reviews[index].profilePhotoUrl),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                new Text(
                                  response.reviews[index].authorName,
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                new Text(
                                  "220,Satyam Corporate",
                                  style: new TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: new Container(
                        // color: Colors.red,
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  "rated".tr,
                                  style: new TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                SmoothStarRating(
                                    allowHalfRating: false,
                                    starCount: 5,
                                    rating: response.reviews[index].rating
                                        .toDouble(),
                                    size: 20.0,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0),
                                SizedBox(
                                  width: 3,
                                ),
                                new Text(
                                  response.reviews[index].rating.toString(),
                                  style: new TextStyle(
                                      color: Colors.amber, fontSize: 15),
                                ),
                              ],
                            ),
                            new Text(
                              response.reviews[index].relativeTimeDescription,
                              style: new TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      flex: 4,
                      child: new Container(
                        child: new Text(
                          response.reviews[index].text,
                          style:
                              new TextStyle(fontSize: 17, color: Colors.grey),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    ),
  );
}

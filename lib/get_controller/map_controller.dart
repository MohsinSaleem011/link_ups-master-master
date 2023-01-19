import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:link_up/helper/app_constant.dart';
import 'package:link_up/model/PlaceDetailsModel.dart' as placelist;
import 'package:link_up/model/PlaceListModel.dart';

class MapController extends GetxController {
  Client client = Client();
  Rx<RestaurantList>? restaurantList;
  Rx<placelist.RestaurantReviews>? restaurantDetails;

  String _getPlaceUrl(String placeName, String lat, String long) {
    var url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=20000&type=$placeName&keyword=$placeName&key=${AppConstant.googleMapApiKey}";
    return url;
  }

  String getImageURL(String refrences) {
    var googleImage =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$refrences&sensor=false&key=${AppConstant.googleMapApiKey}";
    return googleImage;
  }

  String _getPlaceDetailsUrl(String placeId) {
    final urlBase =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=${AppConstant.googleMapApiKey}";
    return urlBase;
  }

  Future<RestaurantList> getAllPlaces(
      String placeName, String lat, String long) async {
    final response =
        await client.get(Uri.parse(_getPlaceUrl(placeName, lat, long)));
    print(['==>', response.body.toString()]);

    RestaurantList resList = RestaurantList();
    resList.results = [];

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      for (var list in decodedJson['results']) {
        if (list['photos'] != null) {
          resList.results?.add(Result.fromJson(list));
        }
      }
      return resList;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future getPlaceDetails(String placeId) async {
    var response = await client.get(Uri.parse(_getPlaceDetailsUrl(placeId)));

    if (response.statusCode == 200) {
      restaurantDetails =
          Rx(placelist.RestaurantReviews.fromJson(json.decode(response.body)));
      update();
    } else {
      throw Exception('Failed to load post');
    }
  }

  void clearPlaceList() {
    if (restaurantList != null) {
      restaurantList = null;
      restaurantDetails = null;
      update();
    }
  }

  void clearPlaceDetails() {
    if (restaurantDetails != null) {
      restaurantDetails = null;
      update();
    }
  }

  void fetchPlaceList(String placeName, String lat, String long) async {
    if (restaurantList != null) {
      restaurantList = null;
      update();
    }
    RestaurantList placeList = await getAllPlaces(placeName, lat, long);
    restaurantList = Rx(placeList);
    update();
  }
}

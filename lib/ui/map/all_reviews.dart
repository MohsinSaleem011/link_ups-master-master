import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/helper/shared_manager.dart';
import 'package:link_up/model/PlaceDetailsModel.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class AllReview extends StatefulWidget {
  final Result response;
  AllReview({Key? key, required this.response}) : super(key: key);

  @override
  _AllReviewState createState() => _AllReviewState();
}

class _AllReviewState extends State<AllReview> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: SharedManager.shared.getThemeType(),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text('all_review'.tr),
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: AppColors.WHITE,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: new Container(
          padding: new EdgeInsets.all(15),
          child: new ListView.builder(
            itemCount: this.widget.response.reviews.length,
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
                                      image: NetworkImage(this
                                          .widget
                                          .response
                                          .reviews[index]
                                          .profilePhotoUrl),
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
                                  this
                                      .widget
                                      .response
                                      .reviews[index]
                                      .authorName,
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                new Text(
                                  "220,Satyam Corporate",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                    rating: this
                                        .widget
                                        .response
                                        .reviews[index]
                                        .rating
                                        .toDouble(),
                                    size: 20.0,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0),
                                SizedBox(
                                  width: 3,
                                ),
                                new Text(
                                  this
                                      .widget
                                      .response
                                      .reviews[index]
                                      .rating
                                      .toString(),
                                  style: new TextStyle(
                                      color: Colors.amber, fontSize: 15),
                                ),
                              ],
                            ),
                            new Text(
                              this
                                  .widget
                                  .response
                                  .reviews[index]
                                  .relativeTimeDescription,
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
                          this.widget.response.reviews[index].text,
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
        ),
      ),
    );
  }
}

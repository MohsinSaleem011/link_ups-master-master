import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future exitConfirmDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'confirm_exit'.tr,
            style: TextStyle(fontFamily: "OpenSans", color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'are_you_sure_exit'.tr,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 16,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                          child: Text(
                            "no".tr,
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.white)),
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                          child: Text(
                            "yes".tr,
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.white)),
                            backgroundColor: Colors.red[900],
                            padding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

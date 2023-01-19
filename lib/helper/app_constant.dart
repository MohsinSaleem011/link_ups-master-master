import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppConstant {
  static const String tokenServerUrl =
      "https://us-central1-linkup-cfa21.cloudfunctions.net/generateToken?";

  static const String googleMapApiKey =
      "AIzaSyDXMEfylOCYGgpFigoFzf-FS6yixy40Mas";

  static const List<Map<String, dynamic>> packages = [
    {"id": "1", "title": "Intro", "price": "23.99", "duration": "1"},
    {"id": "2", "title": "Basic", "price": "70.99", "duration": "3"},
    {"id": "3", "title": "Premium", "price": "95.99", "duration": "12"},
  ];

  static Locale getLocale(String localeCode) {
    switch (localeCode) {
      case 'en':
        return Locale('en', 'US');
      case 'es':
        return Locale('es', 'ES');
      case 'fr':
        return Locale('fr', 'FR');
      default:
        return Locale('en', 'US');
    }
  }

  static String matchMailTmp() {
    return """
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      <html
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:v="urn:schemas-microsoft-com:vml"
        xmlns:o="urn:schemas-microsoft-com:office:office"
      >
        <head>
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <meta name="x-apple-disable-message-reformatting" />
          <meta http-equiv="X-UA-Compatible" content="IE=edge" />
          <title>LinkUp</title>
          <style type="text/css">
            body {
              margin: 0;
              padding: 0;
              background-color: #ffffff00;
            }
            table {
              border-spacing: 0;
            }
            tr,
            td {
              margin: 0;
              padding: 0;
            }
            img {
              border: 0;
            }
            .wrapper {
              width: 100%;
              table-layout: fixed;
              background-color: #ffffff00;
            }
            .main {
              background-color: #ffffff00;
              margin: 0 auto;
              width: 100%;
              max-width: 600px;
              border-spacing: 0;
              font-family: Arial, Helvetica, sans-serif;
            }
            .button {
              background-color: #00532b;
              color: #fcfcfc;
              text-decoration: none;
              padding: 15px 20px;
              font-size: 20px;
              border-radius: 5px;
            }
            .arial-black {
              font-family: "Arial Black", "Arial Bold", Gadget, sans-serif;
            }
          </style>
        </head>
        <body>
          <center class="wrapper">
            <table class="main" width="100%">
              <!-- linkup logo -->
              <tr>
                <td style="text-align: center; padding: 20px 15px">
                  <a href="">
                    <img
                      src="https://linkupvibes.com/admin/img/emailtmplt/linkup.png"
                      alt="Linkup Logo"
                      width="125"
                      title="Linkup Logo"
                      style="max-width: 125px"
                    />
                  </a>
                </td>
              </tr>
              <!-- line separator -->
              <tr>
                <td
                  height="6"
                  style="background-color: #00532b; border-radius: 100%"
                ></td>
              </tr>
              <!-- text set one -->
              <tr>
                <td
                  style="
                    text-align: center;
                    font-size: 22px;
                    color: #00532b;
                    padding: 20px 15px;
                  "
                  class="arial-black"
                >
                  <section style="padding: 5px">
                    <strong>GREAT NEWS!</strong>
                  </section>
                  <section style="padding: 5px">
                    <strong>SOMEONE WOULD LIKE TO LINKUP WITH YOU!</strong>
                  </section>
                </td>
              </tr>
              <!-- couple image -->
              <tr>
                <td>
                  <img
                    src="https://linkupvibes.com/admin/img/emailtmplt/image.jpg"
                    alt="Couple Image"
                    width="600"
                    title="Couple Image"
                    style="max-width: 100%; border-radius: 16px; border: #00532b solid 6px;"
                  />
                </td>
              </tr>
              <!-- button -->
              <tr>
                <td style="text-align: center; padding: 40px 35px 20px 35px">
                  <a
                    href=""
                    target="_blank"
                    class="button arial-black"
                    ><strong>FIND OUT WHO</strong></a
                  >
                </td>
              </tr>
              <!-- text set two -->
              <tr>
                <td
                  style="
                    text-align: center;
                    font-size: 16px;
                    color: #4a4a4a;
                    padding: 20px 15px;
                  "
                >
                  <section style="padding: 5px">
                    <strong>With Linkup,<br /></strong> You can meet Caribbean and
                    Latin American people anywhere in the world.
                  </section>
                  <section style="font-size: 14px; padding: 5px">
                    Join Our Social Media
                  </section>
                </td>
              </tr>
              <!-- social media icons -->
              <tr>
                <td style="text-align: center; font-size: 0">
                  <a href="">
                    <img
                      src="https://linkupvibes.com/admin/img/emailtmplt/instagram.png"
                      alt="Instagram Logo"
                      width="40"
                      title="Instagram Logo"
                      style="max-width: 40px; padding: 5px"
                    />
                  </a>
                  <a href="">
                    <img
                      src="https://linkupvibes.com/admin/img/emailtmplt/twitter.png"
                      alt="Twitter Logo"
                      width="40"
                      title="Twitter Logo"
                      style="max-width: 40px; padding: 5px"
                    />
                  </a>
                  <a href="">
                    <img
                      src="https://linkupvibes.com/admin/img/emailtmplt/facebook.png"
                      alt="Facebook Logo"
                      width="40"
                      title="Facebook Logo"
                      style="max-width: 40px; padding: 5px"
                    />
                  </a>
                </td>
              </tr>
              <!-- text set three -->
              <tr>
                <td
                  style="
                    text-align: center;
                    font-size: 12px;
                    color: #4a4a4a;
                    padding: 20px 15px;
                  "
                >
                  <section style="padding: 5px">
                    This email was sent by LINKUP. To
                    <strong>Unsubscribe</strong>
                    <span>
                      <a
                        href=""
                        target="_blank"
                        style="color: #4a4a4a; text-decoration: none"
                        >Click here.</a
                      >
                    </span>
                  </section>
                  <section style="padding: 5px">
                    575 NW 210 ST. Miami. FL 33169
                  </section>
                  <section style="padding: 5px">
                    © 2022. Bluskies Solutions, LLC. |
                    <strong>
                      <span
                        ><a
                          href=""
                          target="_blank"
                          style="color: #4a4a4a; text-decoration: none"
                          >Privacy Policy</a
                        ></span
                      ></strong
                    >
                  </section>
                </td>
              </tr>
            </table>
          </center>
        </body>
      </html>
      """;
  }

  String getTodaysDate() {
    String d = DateTime.now().day.toString();
    String m = DateTime.now().month.toString();
    String y = DateTime.now().year.toString();
    String r = d + '-' + m + '-' + y;
    return r;
  }

  Future<void> sendMessage({
    required String receiverFcmToken,
    required String msg,
    required String title,
  }) async {
    print('----sending push notification');
    var serverKey =
        'AAAAXhdGTEg:APA91bE3fF9W7JcburkS4J4vPsMdu6ju0UBUh0PPSI53Csoj-SOPtjhXkQX9tzpGKJQLFwLiFu0gbdNV7stIProB3zSlM1RNB21oraGie1JAgMdXBKrTQeklauQS-BECa1PL_yBgUeYx';

    if (receiverFcmToken == '') {
      return;
    }
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg,
              'title': title,
              "badge": "1",
              "sound": "default",
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
            },
            'to': receiverFcmToken,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
}

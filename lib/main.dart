import 'dart:convert';
import 'dart:io' as IO;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:link_up/get_controller/bindings/binding.dart';
import 'package:link_up/helper/app_constant.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/helper/router/router.dart';
import 'package:link_up/helper/shared_pref_service.dart';
import 'package:link_up/helper/translation/translation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

downloadAndSaveFile(String url, String fileName) async {
  var directory = await getApplicationDocumentsDirectory();
  var filePath = '${directory.path}/$fileName';
  var response = await http.get(Uri.parse(url));
  var file = IO.File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<void> showNotificationWithAttachment(
    Map<String, dynamic> notification, notificationPlugin) async {
  var attachmentPicturePath = await downloadAndSaveFile(
      notification['notification']['image_url'], 'attachment_img.jpg');
  var iOSPlatformSpecifics = IOSNotificationDetails(
    attachments: [IOSNotificationAttachment(attachmentPicturePath)],
  );
  var bigPictureStyleInformation = BigPictureStyleInformation(
    FilePathAndroidBitmap(attachmentPicturePath),
    contentTitle: '<b>Attached Image</b>',
    htmlFormatContentTitle: true,
    summaryText: 'Image',
    htmlFormatSummaryText: true,
  );
  var androidChannelSpecifics = AndroidNotificationDetails(
    'channelId',
    'channelDescription',
    importance: Importance.high,
    priority: Priority.high,
    styleInformation: bigPictureStyleInformation,
  );
  var notificationDetails = NotificationDetails(
      android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
  await notificationPlugin.show(
    1,
    notification['notification']['title'],
    notification['notification']['body'],
    notificationDetails,
  );
}

void showNotification(message, notificationPlugin) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channelId', 'channelDescription',
      priority: Priority.high, importance: Importance.max);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  print('----------- showing noti');
  print(message);
  await notificationPlugin.show(
    1,
    message['title'],
    message['body'],
    platformChannelSpecifics,
    payload: json.encode(
      message['data'],
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(event) async {
  Firebase.initializeApp();
  print('====== get background notification ======');
  print(event);
  if (event.notification!.title != 'call') {
    Map<String, dynamic> message = {
      "notification": {
        "title": event.notification!.title,
        "body": event.notification!.body,
        "image_url": ((UniversalPlatform.isAndroid
                ? event.notification!.android!.imageUrl
                : event.notification!.apple!.imageUrl) ??
            "")
      },
      "data": event.data,
      "time": DateTime.now().millisecondsSinceEpoch
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notifications')
        .add(message);
    if (message['notification']['image_url'] != "" &&
        message['notification']['image_url'] != null) {
      showNotificationWithAttachment(message, flutterLocalNotificationsPlugin);
    } else {
      print('------------ trying to show noti');
      print(message);
      showNotification({
        "title": message['notification']['title'],
        "body": message['notification']['body'],
        "data": message['data'],
      }, flutterLocalNotificationsPlugin);
    }
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.microphone.request();
  await Permission.camera.request();
  await Permission.notification.request();
  await Permission.locationAlways.request();
  await Permission.storage.request();
  await SharedPref.instance.getInstance();
 Stripe.publishableKey =
      'pk_test_51FvpC2Hsqr72uLgOjjyR49z2pU6pE7RgyP5OTzP5u0c8iqqzP8ghusd1zsuqjJFek82l8rsizkgRbrSbiim2avst00ooE4eRI7';
  // Stripe.publishableKey =
  //     "pk_test_51IvFOqSJEM1OVJp5LrrcVL0BfFwbSbUtLGNUg7J3gWxExwbtuw1wdZIIU4Q9WtjJShtVMUcojb4iYveSsLX4E14800VZlmxFG6";
  await Stripe.instance.applySettings();

  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {});
  InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Future<void>? onLaunch(Map<String, dynamic> message) {
    print('onLaunch: $message');
    return null;
  }

  // FirebaseMessaging.onMessage.listen((event) async {
  //   print('-----received message-----');
  //   print(event.notification?.title);
  //   Map<String, dynamic> message = {
  //     "notification": {
  //       "title": event.notification!.title,
  //       "body": event.notification!.body,
  //       "image_url": ((UniversalPlatform.isAndroid
  //               ? event.notification!.android!.imageUrl
  //               : event.notification!.apple!.imageUrl) ??
  //           "")
  //     },
  //     "data": event.data,
  //     "time": DateTime.now().millisecondsSinceEpoch
  //   };
  //   if (event.notification?.title == 'call') {
  //     if (event.notification?.body != null) {
  //       var jsonObject = jsonDecode(event.notification!.body!);
  //       if (jsonObject['channel_id'] != null) {
  //         Map<String, dynamic> callInfo = {
  //           "channel_id": jsonObject['channel_id'],
  //           "caller_picture": jsonObject['caller_picture'],
  //           "caller_name": jsonObject['caller_name'],
  //           "caller_uid": jsonObject['caller_uid'],
  //           "call_type": jsonObject['call_type'],
  //           "channel_name": jsonObject['channel_name']
  //         };
  //         Get.to(() => Incoming(callInfo));
  //       }
  //     }
  //   } else {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser?.uid)
  //         .collection('notifications')
  //         .add(message);
  //     if (message['notification']['image_url'] != "" &&
  //         message['notification']['image_url'] != null) {
  //       showNotificationWithAttachment(
  //           message, flutterLocalNotificationsPlugin);
  //     } else {
  //       showNotification(
  //         {
  //           "title": message['notification']['title'],
  //           "body": message['notification']['body'],
  //           "data": message['data'],
  //         },
  //         flutterLocalNotificationsPlugin,
  //       );
  //     }
  //   }
  // });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Map<String, dynamic> notificationObject = {
      "notification": {
        "title": event.notification!.title,
        "body": event.notification!.body,
        "image_url": ((UniversalPlatform.isAndroid
                ? event.notification!.android!.imageUrl
                : event.notification!.apple!.imageUrl) ??
            "")
      },
      "data": event.data
    };

    onLaunch(notificationObject);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> pref = SharedPreferences.getInstance();
    // pref.then((value) => value.remove('uid'));
    // FirebaseAuth.instance.signOut();
    return GetMaterialApp(
      initialBinding: InitBinding(),
      translations: Messages(),
      locale: SharedPref.instance.shared.getString('locale') != null
          ? AppConstant.getLocale(
              SharedPref.instance.shared.getString('locale')!)
          : Locale('en', 'US'),
      title: 'Link Up',
      initialRoute: RoutePath.splash_screen,
      onGenerateRoute: generateRoutes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
// initial Route SPlashScreen

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ziraat_makinem/promo_screen.dart';

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Future<void> notification(context) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  await firebaseMessaging.subscribeToTopic('all');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    String? type = message.data['type'];

    String title = message.notification!.title.toString();
    String body = message.notification!.body.toString();
    if (type == 'promo') {
      String? url = message.data['url'];
      Flushbar(
        barBlur: 1,
        backgroundColor: Colors.black,
        borderRadius: BorderRadius.circular(10),
        title: title,
        message: body,
        padding: EdgeInsets.all(20),
        onTap: (flushbar) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PromoScreen(url: url!)));
        },
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8),
        duration: Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    } else {
      Flushbar(
        barBlur: 1,
        backgroundColor: Colors.black,
        borderRadius: BorderRadius.circular(10),
        title: title,
        message: body,
        padding: EdgeInsets.all(20),
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8),
        duration: Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    }
  });
}

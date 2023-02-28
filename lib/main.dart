import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ziraat_makinem/home_screen.dart';
import 'package:ziraat_makinem/navigator_state.dart';
import 'package:ziraat_makinem/promo_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published! : ${message.data}');
    String? type = message.data['type'];

    if (type == 'promo') {
      String? url = message.data['url'];
      Navigator.push(GlobalVariable.navState.currentContext!, MaterialPageRoute(builder: (context) => PromoScreen(url: url!)));
    }
  });

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalVariable.navState,
      title: 'Ziraat Makinem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}

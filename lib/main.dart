import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notif/api/firebase_api.dart';
import 'package:notif/firebase_options.dart';
import 'package:notif/home_page.dart';
import 'package:notif/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await  FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Notifcaion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomePage(),

      // navigation 
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen' : (context) => const NotificationPage()
      }
    );
  }
}

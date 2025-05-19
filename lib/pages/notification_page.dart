// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // get the notification message and display on screen
//     final message =
//         ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Notification")),
//       body: Column(
//         children: [
//           Text(message?.notification?.title.toString() ?? 'No Title'),
//           Text(message?.notification?.body.toString() ?? 'No Body'),
//           Text(message?.data.toString() ?? 'No Data'),
//         ],
//       ),
//     );
//   }
// }


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // get the notification message and display on screen
    final message =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text("Title"),
            subtitle: Text(message?.notification?.title ?? 'No Title'),
          ),
          const Divider(),
          ListTile(
            title: const Text("Body"),
            subtitle: Text(message?.notification?.body ?? 'No Body'),
          ),
          const Divider(),
          ListTile(
            title: const Text("Data"),
            subtitle: Text(message?.data.toString() ?? 'No Data'),
          ),
        ],
      ),
    );
  }
}

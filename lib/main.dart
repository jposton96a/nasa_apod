import 'package:flutter/material.dart';
import 'pages/details.dart';
import 'pages/feed.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  // Load configuration from environment variables
  await DotEnv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA APOD Demo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: APODFeedPage.routeName,
      routes: {
        APODFeedPage.routeName: (context) => APODFeedPage(),
        APODDetailsPage.routeName: (context) => APODDetailsPage(),
      },
    );
  }
}

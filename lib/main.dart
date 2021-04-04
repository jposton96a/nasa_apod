import 'package:flutter/material.dart';
import 'package:nasa_apod/services/nasa/service.dart';
import 'pages/details.dart';
import 'pages/feed.dart';

// API Key required to access api.nasa.gov
// Can be provided at build time using the following arguments:
// flutter build web --dart-define=NASA_API_KEY="${API_KEY}"
const apiKey = String.fromEnvironment('NASA_API_KEY', defaultValue: 'DEMO_KEY');

main() {
  print("Using API Key: $apiKey");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var _svc = APODService(apiKey: apiKey);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA APOD Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: ThemeData.dark().textTheme,
      ),
      initialRoute: APODFeedPage.routeName,
      routes: {
        APODFeedPage.routeName: (context) => APODFeedPage(service: _svc),
        APODDetailsPage.routeName: (context) => APODDetailsPage(),
      },
    );
  }
}

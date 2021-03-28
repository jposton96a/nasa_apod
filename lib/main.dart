import 'package:flutter/material.dart';
import 'pages/home.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: "Nasa APOD Demo App"),
        '/feed': (context) => APODFeedPage(),
      },
    );
  }
}

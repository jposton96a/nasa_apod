import 'package:flutter/material.dart';

import '../services/nasa/apod.dart';

class APODDetailsPage extends StatelessWidget {
  static const routeName = '/details';

  APODDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final APODResult details = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Image.network(details.url),
            Text(details.title),
            Text(details.explanation),
          ],
        ));
  }
}

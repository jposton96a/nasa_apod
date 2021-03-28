import 'package:flutter/material.dart';

import '../services/nasa/apod.dart';

class APODCard extends StatelessWidget {
  final APODResult apodData;

  APODCard(this.apodData);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.network(this.apodData.url),
        Text(this.apodData.title),
        Text(this.apodData.explanation),
      ],
    ));
  }
}
